# 如果没参数 默认去项目目录中找index.html
pathHtml='index.html'

# Nofind 函数 是否找到文件
IsFind () {
	if [ "0$2" == "0" ];then
		echo "****\033[31mNo find the path of $1\033[0m"
	else
		# 路径数组
		arr=($2)
		if [ 1 -ne ${#arr[*]} ];then

			arr_length=${#arr[*]}
			arr_i=0
			for value in ${arr[*]}
			do
				echo "**$arr_i:) $value"
				let arr_i++
			done
			while read -p "*Select number:" number
			do
				inputNumber=`echo $number | grep '^[0-9]*$'`
				if [ -z "$inputNumber" ];then
					echo "****\033[31mYou are a bad guy.please input a number\033[0m"
					continue
				fi
				if [ $number -lt $arr_length ];then
					break
				else
					echo "****\033[31m $number is out of bouds.Please input right number\033[0m"
				fi
			done
			pathHtml=${arr[$number]}
		fi
	fi
}

# ReadInputIntr 函数 循环输入介绍
ReadInputIntr () {
	echo '******************************************************************'
	echo '\033[35mtips:\033[0mInput:*.html will open this html in browser if exist'
	echo "    Ctrl+c will exit this shell script"
}

# 找到指定html文件 给变量pathHtml
GetPathHtml () {
	pathHtml=`find . -name $1`
	IFS=$'\n'
	arr_path=($pathHtml)
	IsFind $1 "${arr_path[*]}"
}

# 如果没有安装 node 退出 如果没有安装httpserver 提示是否安装
CheckEvm () {
	comm=`type node 2> /dev/null`
	if [ -z "$comm" ];then
		echo "****\033[31mPlease install node.js then execute:npm install -g httpserver. finally i will help you test html well\033[0m"
		echo "****\033[31mDownload node:https://nodejs.org/en/download/\033[0m" 
		exit 1
	fi
	comm=`type httpserver 2> /dev/null`
	if [ -z "$comm" ];then
		read -p '****This shell need install node script: httpserver,does install httpserver now ?(y/n):' flag
		if [ "$flag" == 'y' ];then
			echo "****\033[35mBegin install httpserver ...\033[0m"
			`npm install -g httpserver 1> /dev/null`
			if [ $? -eq 0 ];then
				echo "****\033[35mInstall httpserver success\033[0m"
			else
				echo "****\033[31mInstall httpserver fail\033[m"
				exit 1
			fi
		else
			echo "****\033[31mPlease install node script:httpserver first.\033[0m"
			exit 1
		fi
	fi
}
# split URL
OpenUrlInBrowser () {
		p=$1
		pathHtml=${p:1}
		url="http://localhost:8080${pathHtml}"
		echo "****\033[35mOpen:\033[0m$url"
		`open $url`
}

# execute node script httpserver
StartHttpserver () {
	{`httpserver`}&
}
# is httpserver start
isHttpserverStart () {
	httpserverPid=`ps | grep -h 'node.*httpserver$' | awk '{print $1}'`
}
# kill httpserver
KillHttpserver () {
	`kill -9 $1`
}

# BEGIN=============================================================================

# check environment
CheckEvm

# run httpserver
start=0
isHttpserverStart 
if [ -z "$httpserverPid" ];then
	start=1
	StartHttpserver
fi
	
# intruction input
ReadInputIntr

# wait input
while read -p "*Input new html file:" input
do
	result=`echo $input | grep '.html'`
	if [ -z "$result" ];then
		echo "*\033[31mPlease input *.html file\033[0m"
		continue
	else
		GetPathHtml $input
	fi
	if [ "0$pathHtml" != "0" ];then
		OpenUrlInBrowser $pathHtml
	fi
done

# 捕捉中断信号SIGHUP SIGINT SIGQUIT SIGTERM
trap "$start==1 && KillHttpserver $psOut" 1 2 3 15