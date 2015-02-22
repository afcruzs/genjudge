package unal.edu.gpj

class Problem {
	
	String name
	byte[] pdfDescription
	long timeToAnswer //Time in millisecond
	static hasMany = [ testCases : TestCase ]
	

    static constraints = {
		pdfDescription(nullable:false,maxSize: 3000000 /* 30 mb */)
    }


	@Override
	public String toString() {
		return "Problem [name=" + name + ", timeToAnswer=" + timeToAnswer + "]";
	}
	
	@Override
	public boolean equals(Object o){
		return this.id == ((Problem)o).id
	}
	
	
}
