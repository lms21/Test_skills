Shell：				
--------------------------------------------------------------------------------------
此文件夹包括：
UserSupport自动发送issues及多次点击开关和封装了一些常用的方法。

StartTest_UserSupport.sh：
tap() //封装点击事件，其中有两个参数$1 $2为点击坐标
swipe() //屏幕滑动事件
back()  //返回键点击事件
input() //输入text事件，参数$1为待输入字符串
ActivityIncludeOrNot()  //判断当前界面是否为指定activity，参数$1为待识别的activity名
prepare() //使手机处于亮屏，解锁状态并返回主桌面；只适用于滑动解锁
signUp()  //Usersupport登陆操作；需先进入登陆页面
clearData() //apk清除数据；参数$1为apk包名
1stRun()  //首次进入user support并登录

SendIssue_UserSupport.sh
addPics() //在发送issue时添加图片，只能添加1，2，5张；参数$1为添加张数
inputDescription()  //在发送issue时输入description；参数$1 $2为点击description的坐标
main()  //为发送issue方法，参数$1为发送pictures张数；循环发送30个issues


----------------------------------------------------------------------------------------
在本次学习中，深刻地意识到shell脚本的缺点。
1.在本质上是adb命令操作，在某些操作时会受限于此
2.点击滑动事件只能通过坐标来实现，当改变机型则需要做一轮坐标适配，非常麻烦
