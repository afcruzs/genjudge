package unal.edu.gpj

import java.text.DateFormat

class AdminController {

    def index() { }
	
	def uploadProblem(){}
	
	def doUploadProblem(){
		
		def bytesFile = request.getFile('file').getBytes()
		def name = params.titleInput
		def newProblem = new Problem(name:name,pdfDescription:bytesFile)
		
		def inputCases = request.getMultiFileMap().input
		def outputCases = request.getMultiFileMap().output
		def time = Long.parseLong(params.time)
		
		if( inputCases.size() != outputCases.size() ) {
			render "PLease upload the same amount of input/output files"
		}else{
			inputCases.sort{a,b -> a.getOriginalFilename().toLowerCase() <=> b.getOriginalFilename().toLowerCase()}
			outputCases.sort{a,b -> a.getOriginalFilename().toLowerCase() <=> b.getOriginalFilename().toLowerCase()}
			
			
			for(int i=0; i<inputCases.size(); i++){
				TestCase testCase = new TestCase(
					inputFile:inputCases[i].getBytes(),
					outputFile:outputCases[i].getBytes(),
					timeToAnswer:time)
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
		DateFormat df = DateFormat.getDateInstance();
		Date startDate = df.parse(params.dp1)
		Date endDate = df.parse(params.dp2)
		String name = params.titleInput
		
		Contest newContest = new Contest(name:name,startDate:startDate,finishDate:endDate)
		for(String s : params.keySet()){
			if( s.isNumber() )
				newContest.addToProblems(Problem.get(Long.parseLong(s)))
		}
		newContest.save()
		render newContest
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
}
