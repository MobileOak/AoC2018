#!/bin/zsh

/usr/local/bin/kotlinc -include-runtime -d prog.jar DayOne.kt
/usr/bin/java -jar prog.jar
