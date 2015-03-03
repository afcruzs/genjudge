package unal.edu.gpj

class Submission {
	User user
	Date date
	boolean correct
	boolean timeLimitExceeded
	Problem problem
	byte[] userOutput
    static constraints = {
		userOutput(nullable:false,maxSize:  30000000 /* 3 mb */, type: "blob")
    }
}
