#!/bin/bash
function tap(){
	adb shell input tap $1 $2
	echo "click $1 $2 successfully!"
}
function swipe(){
	adb shell input swipe 346 1228 346 402
	echo swipe
}
function back(){
	adb shell input keyevent 4
	echo "click back key!"
}
function input(){
	adb shell input text $1
	echo "input ($temp) done!"
}
function ActivityIncludeOrNot(){
	str=$(adb shell dumpsys window |findstr "mCurrentFocus=Window")
	str=${str##*/}
	if [[ $str == *$1* ]]
	then 
		echo -e "\n result is \n include $1!"
		return 1
	else 
		echo -e "\n result is \n Not include $1!"
		return 0
	fi
}
function prepare(){
	temp=$(adb shell dumpsys window policy | grep screenState)
		flag_screen=${temp##*=}
		echo -e "\n screen:$flag_screen"
	temp=$(adb shell dumpsys window policy | grep isStatusBarKeyguard) 
		flag_lock=${temp##*=}
		echo -e "\n screen lock:$flag_lock"
	if [[ $flag_screen == *"SCREEN_STATE_OFF"* ]]
	then 	
		adb shell input keyevent 26 #turn on screen
		echo "turn on successfully"
	fi
	if [[ $flag_lock == *"true"* ]]
	then 		
		adb shell input swipe 346 1228 346 402 #unlock screen
		echo "unlock successfully"
	fi
	sleep 2
	adb shell input keyevent 3 #click home button
	echo "phone ready!" 
}

function signUp(){
	input "junyang.liu@tcl.com"
	adb shell input keyevent 61 #click tab button
	input "123456"
	back
	tap $1 $2
}
function clearData(){
	adb shell pm clear $1
}
1stRun(){
	welcome_x=647
	welcome_y=1362
	issue_x=257
	issue_y=300
	signup_enter_x=372
	signup_enter_y=1352
	cActivity='com.tcl.logger.account.SignInActivity'
	prepare
	clearData com.tcl.logger 
	adb shell am start com.tcl.logger/com.tcl.logger.account.WelcomeActivity
	tap $welcome_x $welcome_y
	back
	tap $issue_x $issue_y
	sleep 2
	#str=$(adb shell dumpsys window |findstr "mCurrentFocus=Window")
	#str=${str##*/}
#str=$str | sed 's/ //g'
	ActivityIncludeOrNot $cActivity
	#echo $?
	if [ $? == "1" ] 
	then signUp $signup_enter_x $signup_enter_y
	fi
	sleep 10
	back
}
#1stRun
:<<!
echo "str:$str"
echo ${#str}
echo "cActivity:$cActivity"
echo ${#cActivity}
echo ${str/$cActivity}
#IncludeOrNot str cActivity
if [[ $str == *$cActivity* ]]
then echo -e "\n result is \n include!"
else echo -e "\n result is \n Not include!"
fi
!
