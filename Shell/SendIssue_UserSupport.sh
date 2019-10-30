. ./StartTest_UserSupport.sh
#$1/$2: the position of decription place;
#$3:test phone
#$4:pics numbers
function addPics(){
	tap $1 $2  #add pics buttion in issue page 
	sleep 1
	first_pics_x=160
	first_pics_y=300
	diff=200
	x1=`expr $first_pics_x + $diff`
	tmp=`expr $diff + $diff`
	x2=`expr $first_pics_x + $tmp`
	y1=`expr $first_pics_y + $diff`
	y2=`expr $first_pics_y + $tmp`
	case $3 in 
	1)
		
		tap $first_pics_x $first_pics_y
	;;
	2)
		tap $x1 $first_pics_y
		tap $first_pics_x $first_pics_y
	;;
	5)
		tap $x2 $first_pics_y
		tap $x1 $first_pics_y
		tap $first_pics_x $first_pics_y
		tap $first_pics_x $y1
		tap $first_pics_x $y2
	;;
	esac
	echo "add pics:$3"
	tap 642 104 #need change in different phone 
}
function inputDescription(){
	tap $1 $2
	echo "click decription success!"
	currentTime=`date "+%Y%m%d"`
	str="test-for-user-support\&Date:$currentTime\&phone:$3\&send:$4pics"
	input "$str"
}

#function selectCategory(){}

main(){
#1stRun
#1stRun is doing sign up and fitst prepare
i=0
pics=$1 #pics which are ready to send;can change if you want;
#cActivity=com.tcl.logger.issue.ui.activity.IssueSendActivity
#ActivityIncludeOrNot $cActivity
#flag=$?
#if [ $flag == 1 ]
#then 
while [ $i -lt 30 ]
do
	tap 195 832
	#venice Power position 
	#tap 206 453
	#gauss performance position
	echo "click Power category in venice"
	#echo "click performance category in gauss"
	sleep 2
	ActivityIncludeOrNot $cActivity
	flag=$?
	if [ $flag == 1 ]
	then
	inputDescription 177 710 venice $pics
	#inputDescription 132 760 gauss $pics
	back
	addPics 357 389 $pics 
#venice
	#addPics 376 384 $pics 
	# gauss
	swipe
	tap 353 1404 
	#venice 
	#tap 353 1338  #gauss
	#click send button
	#echo $i
	#echo "$i-send success!"
	else
	        echo "Not in send issue page, fail!"
		break
	fi
	let "i++"
	echo $i
	echo "$i-send success!"
	sleep 180
done
}

main 2
