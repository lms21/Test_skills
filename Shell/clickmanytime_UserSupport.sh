#!/bin/bash
i=1
while [ $i -lt 100 ]
do
	adb shell input tap 965 864
	echo "click $i success!"
	let "i++"
done
