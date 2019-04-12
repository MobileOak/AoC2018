#!/bin/zsh

/usr/local/bin/kotlinc -include-runtime -d prog.jar DayTwo.kt
/usr/bin/java -jar prog.jar
