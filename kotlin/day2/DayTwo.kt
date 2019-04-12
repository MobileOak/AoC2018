import java.io.File

fun main(args: Array<String>) {
    DayTwo().start()
}

class DayTwo {

    fun start() {
        var lines = parseFile("input.txt")
        computePartAResult(lines)
        computePartBResult(lines)
    }

    private fun parseFile(filename : String) : List<String> {
        val ret = ArrayList<String>()
        File(filename).forEachLine {
            ret.add(it)
        }
        return ret
    }

    private fun computePartAResult(lines : List<String>) {
      var twoCount = 0
      var threeCount = 0

      lines.forEach { line ->
        var hash = mutableMapOf<Char, Int>()
        line.forEach { c ->

          val v = if (hash.containsKey(c)) {
	    1 + (hash.get(c) ?: 0)
	  } else {
	    1
	  }
	  hash.put(c, v)
        }

        var foundTwo = 0
	var foundThree = 0
        hash.keys.forEach { k ->
          when (hash.get(k)) {
  	    2 -> foundTwo = 1
  	    3 -> foundThree = 1
  	    else -> {}
	  }
        }
	twoCount += foundTwo
	threeCount += foundThree
	
      }

      print("Two count is $twoCount")
      print("Three count is $threeCount")
      print("Product is " + (twoCount * threeCount))
    }

    private fun computePartBResult(lines : List<String>) {
    }

    private fun print(str : String) {
      System.out.println(str)
    }
}

