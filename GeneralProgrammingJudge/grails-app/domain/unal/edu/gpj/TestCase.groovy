package unal.edu.gpj

class TestCase {
	byte[] inputFile
	byte[] outputFile
    static constraints = {
		inputFile(nullable:false,maxSize:  30000000 /* 3 mb */)
		outputFile(nullable:false,maxSize: 300000000 /* 30 mb */)
    }
}
