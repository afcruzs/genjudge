package unal.edu.gpj
import org.apache.shiro.SecurityUtils

class ContestController {

	def loginService
	def index() {
		render( view: "index", model : [ contests : Contest.list() ] )
	}

	def seeProblems(){
		
		def contest = Contest.get(Long.parseLong(params.contestId))
		
		if(contest.startDate.compareTo(new Date()) > 0 ){
			render(
				view: "seeProblems",
				model : [ notYet : true, startDate : contest.startDate.toString(), contest : contest ] )
		}else if( contest.finishDate.compareTo(new Date()) <= 0 ){
			render(
				view: "seeProblems",
				model : [ finished: true, startDate : contest.startDate.toString(), contest : contest ] )
		}else{
			def submissions = Submission.findAllByUser(loginService.getCurrentUser())
			def problems = Problem.list()
			def submittedProblems = contest.submission.intersect(submissions)
			def alreadySolvedProblems = submittedProblems.findAll{ sub -> sub.correct == true }*.getProblem()
			
			
			def contestDownloads = contest.downloads as List
			
			def waitingDownloads = TestCaseDownload.findAllByUser(loginService.getCurrentUser()).findAll{
					tc ->
						tc.downloadDate.compareTo(new Date()) < 0 &&
						tc.dueDate.compareTo(new Date()) > 0 &&
						contestDownloads.contains(tc)
				} as List
			
			def waitingTestCases = waitingDownloads*.getTestCase()
			
			
			def waitingProblems = []
			def waitingProblems2 = []
			def waitingTime = []
			
			int i = 0
			for(TestCase tc : waitingTestCases){
				def t
				for( Problem p : problems )
					for(TestCase tcc : p.testCases )
						if( tcc.id == tc.id && !alreadySolvedProblems.contains(p) )
							t = p
						
				if(t != null){
					waitingProblems.add( t )
					waitingTime.add( waitingDownloads[i].dueDate.getTime() - (new Date()).getTime() )
				}
				
				
				i++
			}
			
			for(i=0; i<waitingProblems.size(); i++){
				def exp = new Expando()
				exp.problem = waitingProblems[i]
				exp.remainingTime = waitingTime[i]
				waitingProblems2[i] = exp
			}
			
			
			def temp = (waitingProblems + alreadySolvedProblems).intersect(problems)
			
			def contestProblems = contest.getProblems() as List
			
			for( Problem p : temp ){
				contestProblems.remove(p)
			}
			
			
			
			
			render(
				view: "seeProblems",
				model : [
					user : loginService.getCurrentUser(),
					contest : contest,
					alreadySolvedProblems: alreadySolvedProblems,
					waitingProblems : waitingProblems2,
					toBeDownloadedProblems : contestProblems
				] )
		}
		
		
	}
	
	def downloadExample(){
		Problem problem = Problem.get(params.pid)
		def bytes = problem.example
		
		if(bytes == null){
			render "No example for you :("
		}else{
			response.setContentType("application/zip")
			response.setHeader("Content-disposition", "attachment;filename=\"example.zip\"")
			response.outputStream << bytes
		}
	}
	
	def downloadInput(){
		Problem problem = Problem.get(params.pid)
		Contest contest = Contest.get(params.cid)
		def downloads = TestCaseDownload.findAllByUser(loginService.getCurrentUser())
		
		def bytes
		def testCase
		for(TestCase tc : problem.testCases){
			if( downloads.findAll{ down -> down.testCase.id == tc.id }.size() == 0 ){
				testCase = tc
				bytes = tc.inputFile
				break
			}
		}
		
		if( bytes == null ){
			response.setContentType("text/HTML")
			def cid = params.cid
			response.outputStream << "<!DOCTYPE html><html> <head> <title>Admin</title> <meta name='viewport' content='width=device-width, initial-scale=1.0'> <link rel='stylesheet' type='text/css'href='${resource(dir:'css', file:'bootstrap.min.css')}'/><!--[if lt IE 9]> <script src='https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js'></script> <script src='https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js'></script><![endif]--> </head> <body> <g:render template='/templates/header'/> <div align='center'> <h1> <font color='red'>You have downloaded too many inputs :|</font></h1> <a class='btn btn-success btn-lg' href='${createLink(action: 'seeProblems',params:[contestId:cid])}'>Back to contest</a> </div><script src='https://code.jquery.com/jquery.js'></script> <script src='${resource(dir:'', file:'js/bootstrap.min.js')}'></script> </body></html>"
		}else{
			Calendar timeout = Calendar.getInstance();
			Date currDate = new Date()
			Date dueDate = new Date(currDate.getTime() + problem.timeToAnswer)
			/*println problem
			println currDate
			println dueDate*/
			
			TestCaseDownload download = new TestCaseDownload(
					user:loginService.getCurrentUser(),
					testCase:testCase,
					downloadDate: currDate,
					dueDate:dueDate
				)
			
			download.save()
			contest.addToDownloads(download)
			contest.save()
			
			
			response.setContentType("application/text")
			response.setHeader("Content-disposition", "attachment;filename=\"input.txt\"")
			response.outputStream << bytes
		}
		
		
		
		
	}
	
	def saveTlE(){
		try{
			def contest = Contest.get(params.cid)
			def problem = Problem.get(params.pid)
			Submission submission = new Submission(
				user : loginService.getCurrentUser(),
				date : new Date(),
				problem : problem
			)
			submission.setTimeLimitExceeded(true)
			submission.save()
			contest.addToSubmission(submission)
			contest.save()
			render "success"
		}catch(Exception e){
			render "error"
		}
		
				
	}
	
	def uploadOutput(){
		
		def bytesFile = request.getFile('file').getBytes()
		def type = request.getFile('file').contentType
		
		def downloads = TestCaseDownload.findAllByUser(loginService.getCurrentUser()) as TestCaseDownload[]
		def latestDownload = downloads.max{ it.downloadDate }
		def contest = Contest.get(params.cid)
		def problem = Problem.get(params.pid)
		
		Submission submission = new Submission(
			user : loginService.getCurrentUser(),
			date : new Date(),
			problem : problem,
			userOutput : bytesFile
		)
		if( contest.finishDate.compareTo(new Date()) < 0 ){
			render( view: "judgeAnswer", model : [ finished : true, cid : params.cid ] )
		}else if( latestDownload.dueDate.compareTo(new Date()) < 0 ){
			submission.setTimeLimitExceeded(true)
			submission.save()
			contest.addToSubmission(submission)
			contest.save()
			render( view: "judgeAnswer", model : [ outtaTime : true, cid : params.cid ] )
		} else if( type.equals("text/plain") ){
			if( Arrays.equals(latestDownload.testCase.outputFile, bytesFile) ){
				submission.setCorrect(true)
				submission.setTimeLimitExceeded(false)
				submission.save()
				contest.addToSubmission(submission)
				contest.save()
				render( view: "judgeAnswer", model : [ ac : true, cid : params.cid ] )
				
			}else{
				submission.setCorrect(false)
				submission.setTimeLimitExceeded(false)
				submission.save()
				contest.addToSubmission(submission)
				contest.save()
				render( view: "judgeAnswer", model : [ ac : false, cid : params.cid ] )
			}
		}else{
			render( view: "judgeAnswer", model : [ good : false, cid : params.cid ] )
		}
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
}
