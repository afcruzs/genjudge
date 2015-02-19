package unal.edu.gpj

class Problem {
	
	String name
	byte[] pdfDescription
	static hasMany = [ testCases : TestCase ]
	

    static constraints = {
    }
}
