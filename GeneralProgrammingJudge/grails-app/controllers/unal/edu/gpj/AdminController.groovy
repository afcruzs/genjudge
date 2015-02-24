package unal.edu.gpj

import java.text.SimpleDateFormat

import org.apache.shiro.crypto.hash.Sha512Hash

class AdminController {

    def index() { 
		println Problem.list()
		render(view:'index', model : [contests : Contest.list(), problems : Problem.list()] ) }
	
	def createUser(){
		render(view:'createUser',model :[ roles : Role.list()*.getName() ])	
	}
	
	def doCreateUser(){
		def username = params.username
		def password = params.password
		def role = Role.findAllByName(params.roleSelect)
		def user = new User(username: username, passwordHash: new Sha512Hash(password).toHex())
		user.addToRoles(role[0])
		user.save()
		def contests = Contest.list()
		for(Contest c : contests){
			c.addToUsers(user)
			c.save()
		}
		redirect(action:'index')
	}
		
	def uploadProblem(){}
	
	def doUploadProblem(){
		
		def bytesFile = request.getFile('file').getBytes()
		def name = params.titleInput
		def time = Long.parseLong(params.time)
		def newProblem = new Problem(name:name,pdfDescription:bytesFile,timeToAnswer:time)
		
		def inputCases = request.getMultiFileMap().input
		def outputCases = request.getMultiFileMap().output
		
		
		if( inputCases.size() != outputCases.size() ) {
			render "PLease upload the same amount of input/output files"
		}else{
			inputCases = inputCases.sort{a,b -> a.getOriginalFilename().toLowerCase() <=> b.getOriginalFilename().toLowerCase()}
			outputCases = outputCases.sort{a,b -> a.getOriginalFilename().toLowerCase() <=> b.getOriginalFilename().toLowerCase()}
			
			
			for(int i=0; i<inputCases.size(); i++){
				TestCase testCase = new TestCase(
					inputFile:inputCases[i].getBytes(),
					outputFile:outputCases[i].getBytes()
					)
				newProblem.addToTestCases(testCase)
			}
			newProblem.save()
			redirect(action:'index')
		}
	}
	
	def createContest(){
		render( view: "createContest", model : [ problems : Problem.list() ] )
	}
	
	def doCreate(){
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm");		
		Date startDate = formatter.parse(params.dp1)
		Date endDate = formatter.parse(params.dp2)
		String name = params.titleInput
		
		Contest newContest = new Contest(name:name,startDate:startDate,finishDate:endDate)
		for(String s : params.keySet()){
			if( s.isNumber() )
				newContest.addToProblems(Problem.get(Long.parseLong(s)))
		}
		
		//Adds ALL the users to any contest :)
		for( User user : User.list() ){
			newContest.addToUsers(user)
		}
		
		newContest.save()
		redirect(action:'index')
	}
	
	def testProblem(){
		
		def xd = Problem.list()
		def lol = xd.get(0)
		render( view: "testProblem", model : [ problem : lol ] )
		
	}
	
	def getPdf(){
		println "ENtro!!"
		Problem p = Problem.get(params.id)
		if (!p|| !p.pdfDescription || !p.pdfDescription ) {
		  println "ERROOOOOOOOOOOOOORRR"
		  response.sendError(404)
		  return
		}
		response.contentType = p.pdfDescription
		response.contentLength = p.pdfDescription.size()
		
		
		response.setContentType("application/pdf")
        OutputStream out = response.getOutputStream()
        out << p.pdfDescription
        out.flush()
	}

	
	def xd(){
		render Problem.list().size()
	}
	
	def editContest(){
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm");
		def contest = Contest.get(params.contestId)
		String startDate = formatter.format(contest.startDate)
		String finishDate = formatter.format(contest.finishDate)
		render(view:'editContest' ,model : [ contest : contest, startDate : startDate, finishDate : finishDate ] )
	}
	
	def editProblem(){
		render(view:'editProblem', model :[problem:Problem.get(params.problemId)])
	}
	
	def doEditProblem(){
		def bytesFile = request.getFile('file').getBytes()
		def name = params.titleInput
		def time = Long.parseLong(params.time)
		def newProblem = Problem.get(params.problemId)
		newProblem.testCases.clear()
		newProblem.setPdfDescription(bytesFile)
		newProblem.setTimeToAnswer(time)
		newProblem.setName(name)
		
		def inputCases = request.getMultiFileMap().input
		def outputCases = request.getMultiFileMap().output
		
		
		if( inputCases.size() != outputCases.size() ) {
			render "PLease upload the same amount of input/output files"
		}else{
			inputCases = inputCases.sort{a,b -> a.getOriginalFilename().toLowerCase() <=> b.getOriginalFilename().toLowerCase()}
			outputCases = outputCases.sort{a,b -> a.getOriginalFilename().toLowerCase() <=> b.getOriginalFilename().toLowerCase()}
			
			
			for(int i=0; i<inputCases.size(); i++){
				TestCase testCase = new TestCase(
					inputFile:inputCases[i].getBytes(),
					outputFile:outputCases[i].getBytes()
					)
				newProblem.addToTestCases(testCase)
			}
			newProblem.save()
			redirect(action:'index')
		}
	}
	
	def doEditContest(){
		SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm");		
		Date startDate = formatter.parse(params.dp1)
		Date endDate = formatter.parse(params.dp2)
		String name = params.name
		
		Contest contest = Contest.get(params.contestId)
		contest.setStartDate(startDate)
		contest.setFinishDate(endDate)
		contest.setName(name)
		contest.save()
		redirect(action:'index')
	}
	
	def seeContest(){
		def contest = Contest.get(params.contestId)
		def standings = [:]
		def header = ["username"]
		def users = contest.users as List
		def problems = contest.problems as List
		for( Problem problem : problems )
			header.add(problem.name)
		users.sort{it.username}
		for( User user : users ){
			standings[user.username] = []
			println user.username
			for( Problem problem : problems ){
				def userDownloads = contest.downloads.findAll{ down ->
					 			down.user.id == user.id &&
								problem.testCases.findAll{ tc -> tc.id == down.testCase.id }.size() > 0
					  		}
				if( userDownloads != null && userDownloads.size() > 0 ){
					def submissions = contest.submission.findAll{ 
							submission -> 
							submission.user.id == user.id &&
							submission.problem.id == problem.id
						 }
					
					if(submissions == null || submissions.size() == 0){
						standings[user.username].add( "downloaded" )
					}else{
						def latestSubmission = submissions.max{ it.date }
						println problem.name + " " + latestSubmission
						if( latestSubmission.correct )
							standings[user.username].add( "ac" )
						else if( latestSubmission.timeLimitExceeded )
							standings[user.username].add( "tle" )
						else
							standings[user.username].add( "wa" )
					}
				}else{
					standings[user.username].add( "nothing" )
				}
			}
		}
		
		def status
		if( contest.startDate.compareTo(new Date()) > 0 )
			status = "Not started yet, will begin in " + contest.startDate
		else if( contest.finishDate.compareTo(new Date()) <= 0 )
			status = "(Final Standings)"
		else
			status = "(Running) finish date: " + contest.finishDate
			
		render(view:'seeContest',model : [ contestName : contest.name, status: status, standings : standings, users : users, header : header ])
		
	}
}
