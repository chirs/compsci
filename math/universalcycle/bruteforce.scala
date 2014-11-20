


object BruteForce {
  
  def generateStrings(length: Int, chars: List[Int]): List[List[Int]] = {
    if (length == 1){
      for (c <- chars)
	yield List(c)
    }
    else {
      for (c <- chars; l <- generateStrings(length - 1, chars))
	yield c :: l
    }
  }
  
  
  

  def checkString(checked: List[Int], lists: List[List[Int]]): Boolean = {
    (lists :\ False) { (e,a) => a || checked.contains(e)}
  }

  def findString(length: Int, chars: List[Int]): List[Int] = {
    val baseStrings = generateStrings(length, chars)
      
    

  }
		  

		  
		  

		 


  def main(args: Array[String]) {
    val length = args(0).toInt
    val chars = List(1,2,3)
    println(generateStrings(length, chars))
  }
		  


}


  

