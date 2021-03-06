import org.apache.shiro.crypto.hash.Sha512Hash

import unal.edu.gpj.Contest
import unal.edu.gpj.Role
import unal.edu.gpj.User

class BootStrap {

    def init = { servletContext ->
		
		def adminRole = new Role(name: "Administrator")
		adminRole.addToPermissions("*:*")
		adminRole.save()
	   
		def userRole = new Role(name:"User")
		userRole.addToPermissions("Home:index")
		userRole.addToPermissions("Contest:*")
		userRole.save()
	   
		def admin = new User(username: "Admin", passwordHash: new Sha512Hash("password").toHex())
		admin.addToRoles(adminRole)
		admin.save()
	   
		def user = new User(username: "User", passwordHash: new Sha512Hash("password").toHex())
		user.addToRoles(userRole)
		user.save()
    }
    def destroy = {
    }
}
