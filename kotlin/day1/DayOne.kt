import java.io.File;

fun main(args: Array<String>) {
    DayOne().start()
}

class DayOne {

    fun start() {
        var lines = parseFile("input.txt")
        computePartAResult(lines)
        computePartBResult(lines)
    }

    private fun parseFile(filename : String) : ArrayList<String> {
        val ret = ArrayList<String>()
        File(filename).forEachLine {
            ret.add(it)
        }
        return ret;
    }

    private fun computePartAResult(lines : ArrayList<String>) {
        var freq = 0;
        lines.forEach {
            freq += it.toInt()
        }

        println("Frequency is " + freq)
    }

    private fun computePartBResult(lines : ArrayList<String>) {
        var previousValues = HashSet<Int>();
        var freq = 0;
        while(true) {
          lines.forEach {
            freq += it.toInt()
            if (previousValues.contains(freq)) {
              println("The duplicate freq is " + freq);
              return;
            } else {
              previousValues.add(freq);
            }
          }
        }
    }

}

