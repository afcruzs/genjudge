package generalprogrammingjudge

import org.apache.shiro.SecurityUtils

import unal.edu.gpj.Role
import unal.edu.gpj.User


class LoginService {

    def getCurrentUser() {
		return User.findByUsername(SecurityUtils.getSubject().getPrincipal())
    }
	
	def isAdmin(){
		if( getCurrentUser() == null )
			return false
		def roles = getCurrentUser().getRoles()
		for(Role r : roles){
			if( r.name.equals("Administrator") )
				return true
		}
		
		return false
	}
}
