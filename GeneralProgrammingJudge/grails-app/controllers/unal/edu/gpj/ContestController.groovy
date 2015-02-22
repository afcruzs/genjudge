package unal.edu.gpj
import org.apache.shiro.SecurityUtils

class ContestController {

	def loginService
	def index() {
		render( view: "index", model : [ contests : Contest.list() ] )
	}

	def seeProblems(){
		def submissions = Submission.findAllByUser(loginService.getCurrentUser())
		def contest = Contest.get(Long.parseLong(params.contestId))
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
	
	def downloadInput(){
		Problem problem = Problem.get(params.pid)
		Contest contest = Contest.get(params.cid)
		
		def bytes
		def testCase
		for(TestCase tc : problem.testCases){
			bytes = tc.inputFile
			testCase = tc 	
			break
		}
		
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
			problem : problem
		)
		if( latestDownload.dueDate.compareTo(new Date()) < 0 ){
			render "You are outta time"
		} else if( type.equals("text/plain") ){
			if( Arrays.equals(latestDownload.testCase.outputFile, bytesFile) ){
				submission.setCorrect(true)
				submission.save()
				contest.addToSubmission(submission)
				contest.save()
				render( view: "judgeAnswer", model : [ ac : true, cid : params.cid ] )
				
			}else{
				submission.setCorrect(false)
				submission.save()
				contest.addToSubmission(submission)
				contest.save()
				render( view: "judgeAnswer", model : [ ac : false, cid : params.cid ] )
			}
		}else{
		render( view: "judgeAnswer", model : [ good : false, cid : params.cid ] )
		}
	}
}
