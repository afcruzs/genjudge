package unal.edu.gpj

class AdminController {

    def index() { }
	
	def uploadProblem(){}
	
	def doUploadProblem(){
		
		def bytesFile = request.getFile('file').getBytes()
		def name = params.titleInput
		def newProblem = new Problem(name:name,pdfDescription:bytesFile)
		newProblem.save()
		render "LOL" + params
	}
	
	def xd(){
		render Problem.list().size()
	}
}
