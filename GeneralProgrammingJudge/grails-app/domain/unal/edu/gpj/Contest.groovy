package unal.edu.gpj

class Contest {
	String name
	Date startDate
	Date finishDate
	static hasMany = [ problems : Problem, users : User, submission : Submission, downloads : TestCaseDownload ]

	static constraints = {
	}
}
