package unal.edu.gpj

class TestCaseDownload {
	User user
	TestCase testCase
	Date downloadDate
	Date dueDate
    static constraints = {
    }
	
	public String toString(){
		return downloadDate.toString()
	}
	
	public boolean equals(Object o){
		return this.id == ((TestCaseDownload)o).id		
	}
}
