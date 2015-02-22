package unal.edu.gpj

class HeaderTagLib {
	
	def loginService
	def createLinkToHome = { attrs, body ->
		if( loginService.isAdmin() )
			out << g.createLink(controller:'admin',action:'index')
		else
			out << g.createLink(controller:'home',action:'index')
		
	 }
	
	
	def getCurrentUserName = { attrs, body ->
		out << loginService.getCurrentUser().username
		
	 }
}
