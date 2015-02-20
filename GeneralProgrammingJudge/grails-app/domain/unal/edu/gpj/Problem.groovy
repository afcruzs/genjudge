package unal.edu.gpj

class Problem {
	
	String name
	byte[] pdfDescription
	static hasMany = [ testCases : TestCase ]
	

    static constraints = {
		pdfDescription(nullable:false,maxSize: 3000000 /* 30 mb */)
    }
}
