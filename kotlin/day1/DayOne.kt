import java.io.File

fun main(args: Array<String>) {
    DayOne().start()
}

class DayOne {

    fun start() {
        var lines = parseFile("input.txt")
        computePartAResult(lines)
        computePartBResult(lines)
    }

    private fun parseFile(filename : String) : ArrayList<Int> {
        val ret = ArrayList<Int>()
        File(filename).forEachLine {
            ret.add(it.toInt())
        }
        return ret
    }

    private fun computePartAResult(lines : ArrayList<Int>) {
        var freq = lines.sum()
        println("Frequency is " + freq)
    }

    private fun computePartBResult(lines : ArrayList<Int>) {
        var previousValues = HashSet<Int>()
        var freq = 0
        while(true) {
          lines.forEach {
            freq += it
            if (previousValues.contains(freq)) {
              println("The duplicate freq is " + freq)
              return
            } else {
              previousValues.add(freq)
            }
          }
        }
    }

}

