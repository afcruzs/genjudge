package unal.edu.gpj

class HomeController {

    def index() {
      //  render "This page requires a user to be logged in "
    }

    def admin() {
       render "This page requires the logged in user to be an Administrator"
    }
}
