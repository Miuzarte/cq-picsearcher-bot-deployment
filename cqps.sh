#!/bin/bash
PLAIN="\e[0m"          #默认${PLAIN}
BOLD="\e[1m"           #粗体${BOLD}
FAINT="\e[2m"          #弱化${FAINT}
ITALIC="\e[3m"         #斜体${ITALIC}
UNDERLINE="\e[4m"      #下划线${UNDERLINE}
CONCEAL="\e[8m"        #隐藏${CONCEAL}
STRIKE="\e[9m"         #中划线${STRIKE}
FBLACK="\e[30m"        #前景黑色${FBLACK}
FRED="\e[31m"          #前景红色${FRED}
FGREEN="\e[32m"        #前景绿色${FGREEN}
FYELLOW="\e[33m"       #前景黄色${FYELLOW}
FBLUE="\e[34m"         #前景蓝色${FBLUE}
FMAGENTA="\e[35m"      #前景洋红色${FMAGENTA}
FCYAN="\e[36m"         #前景青色${FCYAN}
FWHITE="\e[37m"        #前景灰色${FWHITE}
FBBLACK="\e[90m"       #前景亮黑色${FBBLACK}
FBRED="\e[91m"         #前景亮红色${FBRED}
FBGREEN="\e[92m"       #前景亮绿色${FBGREEN}
FBYELLOW="\e[93m"      #前景亮黄色${FBYELLOW}
FBBLUE="\e[94m"        #前景亮蓝色${FBBLUE}
FBMAGENTA="\e[95m"     #前景亮洋红色${FBMAGENTA}
FBCYAN="\e[96m"        #前景亮青色${FBCYAN}
FBWHITE="\e[97m"       #前景亮灰色${FBWHITE}
BBLACK="\e[40m"        #背景黑色${BBLACK}
BRED="\e[41m"          #背景红色${BBRED}
BGREEN="\e[42m"        #背景绿色${BGREEN}
BYELLOW="\e[43m"       #背景黄色${BBYELLOW}
BBLUE="\e[44m"         #背景蓝色${BBBLUE}
BMAGENTA="\e[45m"      #背景洋红色${BBMAGENTA}
BCYAN="\e[46m"         #背景青色${BBCYAN}
BWHITE="\e[47m"        #背景灰色${BWHITE}
BBBLACK="\e[100m"      #背景亮黑色${BBBLACK}
BBRED="\e[101m"        #背景亮红色${BBRED}
BBGREEN="\e[102m"      #背景亮绿色${BBGREEN}
BBYELLOW="\e[103m"     #背景亮黄色${BBYELLOW}
BBBLUE="\e[104m"       #背景亮蓝色${BBBLUE}
BBMAGENTA="\e[105m"    #背景亮洋红色${BBMAGENTA}
BBCYAN="\e[106m"       #背景亮青色${BBCYAN}
BBWHITE="\e[107m"      #背景亮灰色${BBWHITE}
shloc=$(cd `dirname $0`; pwd)   #脚本所在绝对路径${shloc}
time=$(date "+%Y年%m月%d日%H时%M分%S秒")   #脚本启动时时间${time}
#判断包管理器sudo ${pac} install -y
lsbfile=/etc/lsb-release
rhfile=/etc/redhat-release
if
    test -f "$lsbfile"
then
    pac="apt"
    nodepac="deb"
elif
    test -f "$rhfile"
then
    pac="yum"
    nodepac="rpm"
else
    echo -e "${FBCYAN}Linux${BOLD}发行版判断失败${PLAIN}"
    echo -e "${FBCYAN}${BOLD}请选择当前系统所使用的包管理器${PLAIN}"
    echo -e "${FBCYAN}  1.   apt${PLAIN}"
    echo -e "${FBCYAN}  2.   yum${PLAIN}"
    read -p "Type in the number to choose: " choosen
    case $choosen in
    1)
    #apt
        echo -e "${FBMAGENTA}${BOLD}你选择了${PLAIN}${FBMAGENTA}apt${PLAIN}"
        pac="apt"
        nodepac="deb"
    ;;
    2)
    #yum
        echo -e "${FBMAGENTA}${BOLD}你选择了${PLAIN}${FBMAGENTA}yum${PLAIN}"
        pac="yum"
        nodepac="rpm"
    ;;
    *)
    #Default
        echo -e "${FBMAGENTA}?${PLAIN}"
        exit 1
    ;;
    esac
fi
#基础检测
if
    ! test -f /bin/curl
then
    sudo ${pac} install -y curl
fi
if
    ! test -f /bin/wget
then
    sudo ${pac} install -y wget
fi
if
    ! test -f /bin/git
then
    sudo ${pac} install -y git
fi
if
    ! test -f /bin/screen
then
    sudo ${pac} install -y screen
fi
#判断权限
rootornot=$(id | awk '{print $1}')
clear
if
    [[ $rootornot != *"id=0"*"root"* ]];
then
    echo -e "${FBYELLOW}建议以root身份执行该脚本${PLAIN}"
else
    echo -e "${FBGREEN}root${PLAIN}"
fi
echo -e "------------------------------------------------"
echo -e "cq-picsearcher-bot ${BOLD}懒人管理脚本${PLAIN}"
echo -e "${BOLD}更新时间${PLAIN} 2021/07/29-Thur"
echo -e "https://github.com/Miuzarte/cq-picsearcher-bot-deployment"
echo -e "------------------------------------------------"
echo -e "${FBCYAN}  1.   ${BOLD}${FBGREEN}启动${PLAIN}go-cqhttp${PLAIN}"
echo -e "${FBCYAN}  2.   ${BOLD}${FBGREEN}启动${PLAIN}CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${FBCYAN}  3.   ${BOLD}${FBRED}关闭${PLAIN}go-cqhttp${PLAIN}"
echo -e "${FBCYAN}  4.   ${BOLD}${FBRED}关闭${PLAIN}CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${FBCYAN}  5.   ${BOLD}${FBYELLOW}查看${PLAIN}go-cqhttp${BOLD}${FBYELLOW}日志${PLAIN}"
echo -e "${FBCYAN}  6.   ${BOLD}${FBYELLOW}查看${PLAIN}CQPS${BOLD}${FBYELLOW}     日志${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${FBCYAN}  7.   ${BOLD}${FBMAGENTA}更新${PLAIN}go-cqhttp${PLAIN}"
echo -e "${FBCYAN}  8.   ${BOLD}${FBMAGENTA}更新${PLAIN}CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${FBCYAN}  9.   ${BOLD}${FBBLUE}设置${PLAIN}go-cqhttp crontab@reboot${BOLD}${FBBLUE}自启${PLAIN}"
echo -e "${FBCYAN}  10.  ${BOLD}${FBBLUE}设置${PLAIN}CQPS      crontab@reboot${BOLD}${FBBLUE}自启${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${FBCYAN}  11.  ${BOLD}${FBMAGENTA}部署${PLAIN}go-cqhttp${PLAIN}"
echo -e "${FBCYAN}  12.  ${BOLD}${FBMAGENTA}部署${PLAIN}CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${FBCYAN}  13.  ${BOLD}${FRED}删除${PLAIN}go-cqhttp${PLAIN}"
echo -e "${FBCYAN}  14.  ${BOLD}${FRED}删除${PLAIN}CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${FBCYAN}  15.  ${PLAIN}${BOLD}其他选项${PLAIN}"
echo -e "${FBCYAN}  16.  ${PLAIN}${BOLD}显示项目信息${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e ""
read -p "Type in the number to choose: " choosen
case $choosen in
1)
#启动go-cqhttp
    #判断go-cqhttp进程是否存在
    gcpc=`ps -ef | grep -w go-cqhttp | grep -v grep | wc -l`
    if
        [ $gcpc = 0 ]
    then
        screen_name=$"gocq"
        cmd1=$"cd ${shloc}/go-cqhttp/"
        cmd2=$"./go-cqhttp faststart"
        screen -S $screen_name -X quit
        screen -dmS $screen_name
        screen -x -S $screen_name -p 0 -X stuff "$cmd1"
        screen -x -S $screen_name -p 0 -X stuff $'\n'
        screen -x -S $screen_name -p 0 -X stuff "$cmd2"
        screen -x -S $screen_name -p 0 -X stuff $'\n'
        echo -e "${FBMAGENTA}${BOLD}已创建名为${PLAIN}gocq${FBMAGENTA}${BOLD}的${PLAIN}${FBMAGENTA}screen${BOLD}并启动${PLAIN}${FBMAGENTA}go-cqhttp${PLAIN}"
    else
        echo -e "${FBYELLOW}go-cqhttp${BOLD}正在运行中${PLAIN}"
    fi
;;
2)
#启动CQPS
    cd "${shloc}/cq-picsearcher-bot/"
    npm start
    echo -e "${FBMAGENTA}DONE${PLAIN}"
;;
3)
#关闭go-cqhttp
    #判断go-cqhttp进程是否存在
    gcpc=`ps -ef | grep -w go-cqhttp | grep -v grep | wc -l`
    if
        [ $gcpc = 0 ]
    then
        echo -e "${FBYELLOW}go-cqhttp${BOLD}没有在运行${PLAIN}"
    else
        pkill -P go-cqhttp
        screen -S gocq -X quit
    fi
    echo -e "${FBMAGENTA}DONE${PLAIN}"
;;
4)
#关闭CQPS
    cd "${shloc}/cq-picsearcher-bot/"
    npm stop
    echo -e "${FBMAGENTA}DONE${PLAIN}"
;;
5)
#查看go-cqhttp日志
    #判断go-cqhttp进程是否存在
    gcpc=`ps -ef | grep -w go-cqhttp | grep -v grep | wc -l`
    if
        [ $gcpc = 0 ]
    then
        echo -e "${FBYELLOW}go-cqhttp${BOLD}没有在运行${PLAIN}"
    else
        echo -e "${FBCYAN}${BOLD}进入之后 ${PLAIN}${FBCYAN}'Ctrl + A + D' ${FBCYAN}${BOLD}退出${PLAIN}"
        echo -e "${FBCYAN}${BOLD}回车继续${PLAIN}"
        read -p ""
        screen -r gocq
    fi
;;
6)
#查看CQPS日志
    cd "${shloc}/cq-picsearcher-bot/"
    echo -e "${FBCYAN}进入之后 'Ctrl + C' 退出${PLAIN}"
    echo -e "${FBCYAN}回车继续${PLAIN}"
    read -p ""
    npm run log
;;
7)
#更新go-cqhttp
    echo -e "${FBCYAN}https://github.com/Mrs4s/go-cqhttp/releases${PLAIN}"
    echo -e "${FBCYAN}${BOLD}请${PLAIN}"
;;
8)
#更新CQPS
    cd "${shloc}/cq-picsearcher-bot/"
    npm stop
    git config --global https.https://github.com.proxy url."https://github.com.cnpmjs.org/".insteadOf https://github.com/
    git fetch --all
    git reset --hard origin/master
    git pull
    npm start
    echo -e "${FBMAGENTA}DONE${PLAIN}"
;;
9)
#设置go-cqhttp自启
    checkfile=${shloc}/go-cqhttp/
    if
        test -d "$checkfile"
    then
        rm -rf ${shloc}/go-cqhttp/gocq@reboot.sh
        touch ${shloc}/go-cqhttp/gocq@reboot.sh
        chmod +x ${shxoc}/go-cqhttp/gocq@reboot.sh
        echo "#!/bin/bash" >> ${shloc}/go-cqhttp/gocq@reboot.sh
        echo "screen_name=$\"gocq\"" >> ${shloc}/go-cqhttp/gocq@reboot.sh
        echo "cmd1=$\"cd ${shloc}/go-cqhttp/\"" >> ${shloc}/go-cqhttp/gocq@reboot.sh
        echo "cmd2=$\"./go-cqhttp faststart\"" >> ${shloc}/go-cqhttp/gocq@reboot.sh
        echo "screen -dmS \$screen_name" >> ${shloc}/go-cqhttp/gocq@reboot.sh
        echo "screen -x -S \$screen_name -p 0 -X stuff \"\$cmd1\"" >> ${shloc}/go-cqhttp/gocq@reboot.sh
        echo "screen -x -S \$screen_name -p 0 -X stuff $'\\n'" >> ${shloc}/go-cqhttp/gocq@reboot.sh
        echo "screen -x -S \$screen_name -p 0 -X stuff \"\$cmd2\"" >> ${shloc}/go-cqhttp/gocq@reboot.sh
        echo "screen -x -S \$screen_name -p 0 -X stuff $'\\n'" >> ${shloc}/go-cqhttp/gocq@reboot.sh
        (echo -e "@reboot ${shloc}/go-cqhttp/gocq@reboot.sh" ; crontab -l ) | crontab
        echo -e "${FBMAGENTA}${BOLD}已向 ${PLAIN}crontab -e ${FBMAGENTA}${BOLD}写入 ${PLAIN}${FMAGENTA}@reboot ${FYELLOW}${shloc}/go-cqhttp/gocq@reboot.sh${PLAIN}"
        echo -e "${FBYELLOW}${BOLD}在第二次设置自启前请确认已删除 ${PLAIN}${FBYELLOW}crontab -e ${BOLD}内的 ${PLAIN}${FMAGENTA}@reboot ${FYELLOW}${shloc}/go-cqhttp/gocq@reboot.sh${PLAIN}"
        echo -e "${FBMAGENTA}DONE${PLAIN}"
    else
        echo -e "${FBRED}go-cqhttp${BOLD}未部署${PLAIN}"
    fi
;;
10)
#设置CQPS自启
    echo -e "${FBMAGENTA}CQPS启动后就会由pm2守护运行${PLAIN}"
    echo -e "${FBMAGENTA}所以说是不需要自启的${PLAIN}"
    echo -e "${FBCYAN}当然你要是真的有这个需求你也不是不能设${PLAIN}"
    echo -e "${FBCYAN}  1.   ${BOLD}设置${PLAIN}${FBCYAN}CQPS${BOLD}自启${PLAIN}"
    echo -e "${FBCYAN}  2.   ${BOLD}不设置${PLAIN}${FBCYAN}CQPS${BOLD}自启${PLAIN}"
    read -p "Type in the number to choose: " choosen
    case $choosen in
    1)
    #设置
        checkfile=${shloc}/cq-picsearcher-bot
        if
            test -d "$checkfile"
        then
            rm -rf ${shloc}/cq-picsearcher-bot/cqps@reboot.sh
            touch ${shloc}/cq-picsearcher-bot/cqps@reboot.sh
            chmod 700 ${shloc}/cq-picsearcher-bot/cqps@reboot.sh
            echo "#!/bin/bash" >> ${shloc}/cq-picsearcher-bot/cqps@reboot.sh
            echo "screen_name=$\"CQPS\"" >> ${shloc}/cq-picsearcher-bot/cqps@reboot.sh
            echo "cmd1=$\"cd ${shloc}/cq-picsearcher-bot/\"" >> ${shloc}/cq-picsearcher-bot/cqps@reboot.sh
            echo "cmd2=$\"npm start\"" >> ${shloc}/cq-picsearcher-bot/cqps@reboot.sh
            echo "cmd3=$\"exit\"" >> ${shloc}/cq-picsearcher-bot/cqps@reboot.sh
            echo "screen -dmS \$screen_name" >> ${shloc}/cq-picsearcher-bot/cqps@reboot.sh
            echo "screen -x -S \$screen_name -p 0 -X stuff \"\$cmd1\"" >> ${shloc}/cq-picsearcher-bot/cqps@reboot.sh
            echo "screen -x -S \$screen_name -p 0 -X stuff $'\\n'" >> ${shloc}/cq-picsearcher-bot/cqps@reboot.sh
            echo "screen -x -S \$screen_name -p 0 -X stuff \"\$cmd2\"" >> ${shloc}/cq-picsearcher-bot/cqps@reboot.sh
            echo "screen -x -S \$screen_name -p 0 -X stuff $'\\n'" >> ${shloc}/cq-picsearcher-bot/cqps@reboot.sh
            echo "screen -x -S \$screen_name -p 0 -X stuff \"\$cmd3\"" >> ${shloc}/cq-picsearcher-bot/cqps@reboot.sh
            echo "screen -x -S \$screen_name -p 0 -X stuff $'\\n'" >> ${shloc}/cq-picsearcher-bot/cqps@reboot.sh
            (echo -e "@reboot ${shloc}/cq-picsearcher-bot/cqps@reboot.sh" ; crontab -l ) | crontab
            echo -e "${FBMAGENTA}${BOLD}已向 ${PLAIN}crontab -e ${FBMAGENTA}${BOLD}写入 ${PLAIN}${FMAGENTA}@reboot ${FYELLOW}${shloc}/cq-picsearcher-bot/cqps@reboot.sh${PLAIN}"
            echo -e "${FBYELLOW}${BOLD}在第二次设置自启前请确认已删除 ${PLAIN}${FBYELLOW}crontab -e ${BOLD}内的 ${PLAIN}${FMAGENTA}@reboot ${FYELLOW}${shloc}/cq-picsearcher-bot/cqps@reboot.sh${PLAIN}"
            echo -e "${FBMAGENTA}DONE${PLAIN}"
        else
            echo -e "${FBRED}cq-picsearcher-bot${BOLD}未部署${PLAIN}"
        fi
    ;;
    *)
    #不设置
        echo -e "${FBMAGENTA}DONE${PLAIN}"
    ;;
    esac
;;
11)
#部署go-cqhttp
    #判断是否二次部署
    checkfile=${shloc}/go-cqhttp/
    if
        test -d "$checkfile"
    then
        mv "${shloc}/go-cqhttp/" "${shloc}/go-cqhttp.old/"
        echo -e "${FBMAGENTA}${BOLD}检测到存在${PLAIN}${FBMAGENTA}${shloc}/go-cqhttp/${BOLD}文件夹，已备份为${PLAIN}${FBMAGENTA}${shloc}/go-cqhttp.old/${PLAIN}"
    fi
    mkdir "${shloc}/go-cqhttp/"
    mkdir "${shloc}/cqps.sh.download/"
    #判断架构
    unamem=$(uname -m)
    echo -e "${FBMAGENTA}${BOLD}系统架构为${PLAIN}{FBMAGENTA}${unamem}${PLAIN}"
    case $unamem in
    x86_64)
    #amd64
        echo -e "${FBMAGENTA}${BOLD}开始部署${PLAIN}{FBMAGENTA}go-cqhttp_linux_amd64${PLAIN}"
        wget -P "${shloc}/cqps.sh.download/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta4/go-cqhttp_linux_amd64.tar.gz"
        tar -zxvf "${shloc}/cqps.sh.download/go-cqhttp_linux_amd64.tar.gz" -C "${shloc}/go-cqhttp/"
    ;;
    aarch64)
    #ARMv8
        echo -e "${FBMAGENTA}${BOLD}开始部署${PLAIN}{FBMAGENTA}go-cqhttp_linux_arm64${PLAIN}"
        wget -P "${shloc}/cqps.sh.download/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta4/go-cqhttp_linux_arm64.tar.gz"
        tar -zxvf "${shloc}/cqps.sh.download/go-cqhttp_linux_arm64.tar.gz" -C "${shloc}/go-cqhttp/"
    ;;
    armv7l)
    #ARMv7
        echo -e "${FBMAGENTA}${BOLD}开始部署${PLAIN}{FBMAGENTA}go-cqhttp_linux_armv7${PLAIN}"
        wget -P "${shloc}/cqps.sh.download/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta4/go-cqhttp_linux_armv7.tar.gz"
        tar -zxvf "${shloc}/cqps.sh.download/go-cqhttp_linux_armv7.tar.gz" -C "${shloc}/go-cqhttp/"
    ;;
    *)
    #unknown
        echo -e "${FBRED}${BOLD}这是个未知的架构${PLAIN}"
        echo -e "${FBCYAN}${BOLD}请选择所需部署的${PLAIN}${FBCYAN}go-cqhttp${PLAIN}"
        echo -e "${FBCYAN}  1.   amd64${PLAIN}"
        echo -e "${FBCYAN}  2.   ARMv8${PLAIN}"
        echo -e "${FBCYAN}  3.   ARMv7${PLAIN}"
        echo -e "${FBCYAN}  4.   i386${PLAIN}"
        echo -e ""
        read -p "Type in the number to choose: " choosen
        case $choosen in
        1)
        #amd64
            echo -e "${FBMAGENTA}${BOLD}开始部署${PLAIN}{FBMAGENTA}go-cqhttp_linux_amd64${PLAIN}"
            wget -P "${shloc}/cqps.sh.download/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta4/go-cqhttp_linux_amd64.tar.gz"
            tar -zxvf "${shloc}/cqps.sh.download/go-cqhttp_linux_amd64.tar.gz" -C "${shloc}/go-cqhttp/"
        ;;
        2)
        #ARMv8
            echo -e "${FBMAGENTA}${BOLD}开始部署${PLAIN}{FBMAGENTA}go-cqhttp_linux_arm64${PLAIN}"
            wget -P "${shloc}/cqps.sh.download/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta4/go-cqhttp_linux_arm64.tar.gz"
            tar -zxvf "${shloc}/cqps.sh.download/go-cqhttp_linux_arm64.tar.gz" -C "${shloc}/go-cqhttp/"
        ;;
        3)
        #ARMv7
            echo -e "${FBMAGENTA}${BOLD}开始部署${PLAIN}{FBMAGENTA}go-cqhttp_linux_armv7${PLAIN}"
            wget -P "${shloc}/cqps.sh.download/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta4/go-cqhttp_linux_armv7.tar.gz"
            tar -zxvf "${shloc}/cqps.sh.download/go-cqhttp_linux_armv7.tar.gz" -C "${shloc}/go-cqhttp/"
        ;;
        4)
        #i386
            echo -e "${FBMAGENTA}${BOLD}开始部署${PLAIN}{FBMAGENTA}go-cqhttp_linux_386${PLAIN}"
            wget -P "${shloc}/cqps.sh.download/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta4/go-cqhttp_linux_386.tar.gz"
            tar -zxvf "${shloc}/cqps.sh.download/go-cqhttp_linux_386.tar.gz" -C "${shloc}/go-cqhttp/"
        ;;
        esac
    ;;
    esac
    rm -rf "${shloc}/cqps.sh.download/"
    chmod +x "${shloc}/go-cqhttp/go-cqhttp"
    cd "${shloc}/go-cqhttp/"
    echo -e "${FBCYAN}${BOLD}接下来请选择${PLAIN}"
    echo -e "${FBCYAN}2: ${BOLD}正向 ${PLAIN}${FBCYAN}Websocket ${BOLD}通信${PLAIN}"
    echo -e "${FBCYAN}${BOLD}输入2之后一共按两次回车${PLAIN}"
    ./go-cqhttp faststart
    echo -e "${FBCYAN}${BOLD}项目拉取完毕，是否开始填写 ${PLAIN}${FBCYAN}config.yml ${BOLD}基础配置项${PLAIN}"
    echo -e "${FBGREEN}// ${BOLD}输入项无需任何引号${PLAIN}"
    echo -e "${FBCYAN}  1.   Yes${PLAIN}"
    echo -e "${FBCYAN}  2.   No${PLAIN}"
    echo -e ""
    read -p "Type in the number to choose: " choosen
    case $choosen in
    1)
    #Yes
        echo -e "${FBMAGENTA}${BOLD}你选择了${PLAIN}${FBMAGENTA}Yes${PLAIN}"
        echo -e ""
        #"uin"
        echo -e "${FBCYAN}QQ${BOLD}号${PLAIN}"
        read -p "uin: " input
        sed -i 's|uin: .*|uin: '"${input}"'|' "${shloc}/go-cqhttp/config.yml"
        echo -e ""
        #"password"
        echo -e "${FBCYAN}QQ${BOLD}密码，留空则使用扫码登陆${PLAIN}"
        read -p "password: " input
        sed -i 's|password: '.*'|password: '\'''"${input}"''\''|' "${shloc}/go-cqhttp/config.yml"
        echo -e ""
        #"access_token"
        echo -e "${FBCYAN}${BOLD}访问密钥，强烈推荐在公网的服务器设置，可留空${PLAIN}"
        read -p "access_token: " input
        sed -i 's|access-token: '.*'|access-token: '\'''"${input}"''\''|' "${shloc}/go-cqhttp/config.yml"
        echo -e ""
        echo -e "${FBMAGENTA}DONE${PLAIN}"
    ;;
    2)
    #No
        echo -e "${FBMAGENTA}${BOLD}你选择了${PLAIN}${FBMAGENTA}No${PLAIN}"
        echo -e "${FBMAGENTA}DONE${PLAIN}"
    ;;
    *)
    #Default
        echo -e "${FBMAGENTA}${BOLD}默认选择${PLAIN}${FBMAGENTA}No${PLAIN}"
        echo -e "${FBMAGENTA}DONE${PLAIN}"
    ;;
    esac
    echo -e "${FBCYAN}${BOLD}是否自动备份${PLAIN}${FBCYAN}go-cqhttp${BOLD}历史记录${PLAIN}"
    echo -e "${FBCYAN}go-cqhttp${BOLD}只会保留前七天+今天的日志"
    echo -e "${FBCYAN}  1.   Yes${PLAIN}"
    echo -e "${FBCYAN}  2.   No${PLAIN}"
    echo -e ""
    read -p "Type in the number to choose: " choosen
    case $choosen in
    1)
    #Yes
        mkdir "${shloc}/go-cqhttp/logs.old/"
        (echo -e "0 * * * * cp -rf ${shloc}/go-cqhttp/logs/* ${shloc}/go-cqhttp/logs.old/" ; crontab -l ) | crontab
        echo -e "${FBMAGENTA}${BOLD}已向 ${PLAIN}crontab -e ${FBMAGENTA}${BOLD}写入 ${PLAIN}${FRED}0 ${FMAGENTA}/* ${FGREEN}* ${FRED}* ${FMAGENTA}* ${FYELLOW}cp -rf ${shloc}/go-cqhttp/logs/* ${shloc}/go-cqhttp/logs.old/${PLAIN}"
        echo -e "${FBMAGENTA}DONE${PLAIN}"
    ;;
    2)
    #No
        echo -e "${FBMAGENTA}${BOLD}你选择了${PLAIN}${FBMAGENTA}No${PLAIN}"
        echo -e "${FBMAGENTA}DONE${PLAIN}"
    ;;
    *)
    #Default
        echo -e "${FBMAGENTA}${BOLD}默认选择${PLAIN}${FBMAGENTA}No${PLAIN}"
        echo -e "${FBMAGENTA}DONE${PLAIN}"
    ;;
    esac
;;
12)
#部署CQPS
    #判断node
    checkfile=/bin/node
    if
        test -f "$checkfile"
    then
        nodever=$(node -v)
        case $nodever in
        "v14."*)
            echo -e "${FBMAGENTA}${BOLD}当前${PLAIN}${FBMAGENTA}nodejs${BOLD}版本: ${PLAIN}${nodever}"
        ;;
        "v15."*)
            echo -e "${FBMAGENTA}${BOLD}当前${PLAIN}${FBMAGENTA}nodejs${BOLD}版本: ${PLAIN}${nodever}"
        ;;
        "v16."*)
            echo -e "${FBMAGENTA}${BOLD}当前${PLAIN}${FBMAGENTA}nodejs${BOLD}版本: ${PLAIN}${nodever}"
        ;;
        "v17."*)
            echo -e "${FBMAGENTA}${BOLD}当前${PLAIN}${FBMAGENTA}nodejs${BOLD}版本: ${PLAIN}${nodever}"
        ;;
        "v18."*)
            echo -e "${FBMAGENTA}${BOLD}当前${PLAIN}${FBMAGENTA}nodejs${BOLD}版本: ${PLAIN}${nodever}"
        ;;
        "v19."*)
            echo -e "${FBMAGENTA}${BOLD}当前${PLAIN}${FBMAGENTA}nodejs${BOLD}版本: ${PLAIN}${nodever}"
        ;;
        "v20."*)
            echo -e "${FBMAGENTA}${BOLD}当前${PLAIN}${FBMAGENTA}nodejs${BOLD}版本: ${PLAIN}${nodever}"
        ;;
        "v21."*)
            echo -e "${FBMAGENTA}${BOLD}当前${PLAIN}${FBMAGENTA}nodejs${BOLD}版本: ${PLAIN}${nodever}"
        ;;
        *)
            echo -e "${FBMAGENTA}${BOLD}当前${PLAIN}${FBMAGENTA}nodejs${BOLD}版本: ${PLAIN}${nodever}"
            echo -e "${FBMAGENTA}${BOLD}不符合${PLAIN}${FBMAGENTA}cqps${BOLD}所要求的${PLAIN}${FBMAGENTA}v14+${BOLD}，开始安装目前的lts版本${PLAIN}"
            curl -fsSL https://${nodepac}.nodesource.com/setup_lts.x | sudo bash -
            sudo ${pac} install -y nodejs
        ;;
        esac
    else
        curl -fsSL https://${nodepac}.nodesource.com/setup_lts.x | sudo bash -
        sudo ${pac} install -y nodejs
    fi
    #判断是否二次部署
    checkfile=${shloc}/cq-picsearcher-bot/
    if
        test -d "$checkfile"
    then
        mv "${shloc}/cq-picsearcher-bot/" "${shloc}/cq-picsearcher-bot.old/"
        echo -e "${FBMAGENTA}${BOLD}检测到存在${PLAIN}${FBMAGENTA}${shloc}/cq-picsearcher-bot/${BOLD}文件夹，已备份为${PLAIN}${FBMAGENTA}${shloc}/cq-picsearcher-bot.old/${PLAIN}"
    fi
        git clone "https://github.com.cnpmjs.org/Tsuk1ko/cq-picsearcher-bot"
        cp "${shloc}/cq-picsearcher-bot/config.default.jsonc" "${shloc}/cq-picsearcher-bot/config.jsonc"
        cd "${shloc}/cq-picsearcher-bot/"
    echo -e ""
    echo -e "${FBCYAN}${BOLD}选择${PLAIN}${FBCYAN}yarn${BOLD}源${PLAIN}"
    echo -e "${FBCYAN}  1.   ${BOLD}官方源${FAINT}(海外)${PLAIN}"
    echo -e "${FBCYAN}  2.   ${BOLD}阿里镜像源${FAINT}(大陆)${PLAIN}"
    echo -e ""
    read -p "Type in the number to choose: " choosen
    case $choosen in
    1)
    #官方源(海外)
        echo -e "${FBMAGENTA}${BOLD}你选择了官方源${PLAIN}"
        npm i --force -g yarn
        yarn
    ;;
    2)
    #阿里镜像源(大陆)
        echo -e "${FBMAGENTA}${BOLD}你选择了阿里镜像源${PLAIN}"
        npm i --force -g yarn --registry=https://registry.npm.taobao.org
        yarn config set registry https://registry.npm.taobao.org --global
        yarn config set disturl https://npm.taobao.org/dist --global
        yarn
    ;;
    *)
    #Default
        echo -e "${FBMAGENTA}${BOLD}默认选择阿里镜像源${PLAIN}"
        npm i --force -g yarn --registry=https://registry.npm.taobao.org
        yarn config set registry https://registry.npm.taobao.org --global
        yarn config set disturl https://npm.taobao.org/dist --global
        yarn
    ;;
    esac
    echo -e ""
    echo -e "${FBCYAN}${BOLD}项目拉取完毕,是否开始填写 ${PLAIN}${FBCYAN}config.jsonc ${BOLD}基础配置项${PLAIN}"
    echo -e "${FBGREEN}// ${BOLD}输入项无需任何引号${PLAIN}"
    echo -e "${FBCYAN}  1.   Yes${PLAIN}"
    echo -e "${FBCYAN}  2.   No${PLAIN}"
    echo -e ""
    read -p "Type in the number to choose: " choosen
    case $choosen in
    1)
    #Yes
        echo -e "${FBMAGENTA}${BOLD}你选择了${PLAIN}${FBMAGENTA}Yes${PLAIN}"
        echo -e ""
        #"autoUpdateConfig"
        echo -e "${FBCYAN}${BOLD}是否启用自动更新 ${PLAIN}${FBCYAN}config.jsonc${PLAIN}"
        echo -e "${FBCYAN}  1.   true${PLAIN}(建议)"
        echo -e "${FBCYAN}  2.   false${PLAIN}(默认)"
        echo -e ""
    read -p "Type in the number to choose: " choosen
        case $choosen in
        1)
        #true
            echo -e "${FBMAGENTA}${BOLD}你选择了${PLAIN}${FBMAGENTA}true${PLAIN}"
            sed -i 's|"autoUpdateConfig": false,|"autoUpdateConfig": true,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        ;;
        2)
        #false
            echo -e "${FBMAGENTA}${BOLD}你选择了${PLAIN}${FBMAGENTA}false${PLAIN}"
        ;;
        *)
        #Default
            echo -e "${FBMAGENTA}${BOLD}默认选择${PLAIN}${FBMAGENTA}false${PLAIN}"
        ;;
        esac
        echo -e ""
        #"port"
        echo -e "${FBCYAN}go-cqhttp ws${BOLD}端口，留空则保持默认${PLAIN}${FBCYAN}6700${PLAIN}"
        read -p "\"port\": " input
        if
            [ "$input" = "" ]
        then
            echo -e "${BOLD}保持默认${PLAIN}(6700)"
        else
            sed -i 's|"port": .*,|"port": '"${input}"',|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        fi
        echo -e ""
        #"accessToken"
        echo -e "${FBCYAN}go-cqhttp ${BOLD}访问密钥，无则留空${PLAIN}"
        read -p "\"accessToken\": " input
        sed -i 's|"accessToken": ".*",|"accessToken": "'"${input}"'",|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        echo -e ""
        #"admin"
        echo -e "${FBCYAN}${BOLD}管理者${PLAIN}${FBCYAN}QQ${BOLD}，必填${PLAIN}"
        read -p "\"admin\": " input
        sed -i 's|"admin": .*,|"admin": '"${input}"',|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        echo -e ""
        #"proxy"
        echo -e "${FBCYAN}${BOLD}大部分请求所使用的代理，留空则不使用代理${PLAIN}"
        echo -e "${FBCYAN}${BOLD}支持 ${PLAIN}${FBCYAN}http(s):// ${BOLD}和 ${PLAIN}${FBCYAN}socks://${PLAIN}"
        echo -e "${FBGREEN}\"[https(s)/socks]://[IP]:[Port]\"${PLAIN}"
        read -p "\"proxy\": " input
        if
            [ "input" = "" ]
        then
            echo -e "${BOLD}保持默认(不使用代理)"
        else
            sed -i 's|"proxy": ".*",|"proxy": "'"${input}"'",|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        fi
        echo -e ""
        #"saucenaoApiKey"
        echo -e "${FBCYAN}saucenao APIKEY${BOLD}，必填，否则无法使用 ${PLAIN}${FBCYAN}saucenao ${BOLD}搜图，留空则跳过${PLAIN}"
        echo -e "${FBCYAN}${BOLD}前往${PLAIN}"
        echo -e "https://saucenao.com/user.php"
        echo -e "${FBCYAN}${BOLD}注册登录之后${PLAIN}"
        echo -e "${FBCYAN}${BOLD}再到${PLAIN}"
        echo -e "https://saucenao.com/user.php?page=search-api"
        echo -e "${FBCYAN}${BOLD}复制${PLAIN}${FBCYAN}api key${PLAIN}"
        read -p "\"saucenaoApiKey\": " input
        sed -i 's|"saucenaoApiKey": ".*",|"saucenaoApiKey": "'"${input}"'",|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        echo -e "${FBMAGENTA}DONE${PLAIN}"
    ;;
    *)
    #No
        echo -e "${FBMAGENTA}${BOLD}你选择了${PLAIN}${FBMAGENTA}No${PLAIN}"
        echo -e "${FBCYAN}${BOLD}是否启用自动更新 ${PLAIN}${FBCYAN}config.jsonc${PLAIN}"
        echo -e "${FBCYAN}  1.   true${PLAIN}(建议)"
        echo -e "${FBCYAN}  2.   false${PLAIN}(默认)"
        echo -e ""
        read -p "Type in the number to choose: " choosen
        case $choosen in
        1)
        #true
            sed -i 's|"autoUpdateConfig": false,|"autoUpdateConfig": true,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
            echo -e "${FBMAGENTA}${BOLD}你选择了${PLAIN}${FBMAGENTA}true${PLAIN}"
        ;;
        2)
        #false
            echo -e "${FBMAGENTA}${BOLD}你选择了${PLAIN}${FBMAGENTA}false${PLAIN}"
        ;;
        *)
        #Default
            echo -e "${FBMAGENTA}${BOLD}默认选择${PLAIN}${FBMAGENTA}false${PLAIN}"
        ;;
        esac
        echo -e "${FBMAGENTA}DONE${PLAIN}"
    ;;
    esac
;;
13)
#删除go-cqhttp
    #判断go-cqhttp进程是否存在
    gcpc=`ps -ef | grep -w go-cqhttp | grep -v grep | wc -l`
    if
        [ $gcpc = 0 ]
    then
        checkfile=${shloc}/go-cqhttp/
        if
            test -d "$checkfile"
        then
            rm -rf "${shloc}/go-cqhttp/"
        else
            echo -e "${FBRED}go-cqhttp${BOLD}未部署${PLAIN}"
        fi
    else
        cho -e "${FBYELLOW}go-cqhttp${BOLD}正在运行中${PLAIN}"
    fi
;;
14)
#删除CQPS
    checkfile=${shloc}/cq-picsearcher-bot/
    if
        test -d "$checkfile"
    then
        cd "${shloc}/cq-picsearcher-bot/"
        npm stop
        npx pm2 kill
        rm -rf "${shloc}/cq-picsearcher-bot/"
    else
        echo -e "${FBRED}cq-picsearcher-bot${BOLD}未部署${PLAIN}"
    fi
;;
15)
#其他选项
    clear
    echo -e "${BBLACK}------------------------------------------------${PLAIN}"
    echo -e "${FBCYAN}  1.   ${BOLD}(大概率能)修复${PLAIN}${FBCYAN}CQPS${BOLD}无法启动${PLAIN}"
    echo -e "${BBLACK}------------------------------------------------${PLAIN}"
    echo -e "${FBCYAN}  2.   ${BOLD}自动备份${PLAIN}${FBCYAN}go-cqhttp${BOLD}日志${PLAIN}"
    echo -e "${BBLACK}------------------------------------------------${PLAIN}"
    echo -e "${FBCYAN}  3.   ${BOLD}启用自动更新${PLAIN}${FBCYAN}config.jsonc${PLAIN}"
    echo -e "${FBCYAN}  4.   ${BOLD}停用自动更新${PLAIN}${FBCYAN}config.jsonc${PLAIN}"
    echo -e "${BBLACK}------------------------------------------------${PLAIN}"
    echo -e "${FBCYAN}  5.   ${BOLD}通过二进制文件安装${PLAIN}${FBCYAN}nodejs${PLAIN}"
    echo -e "${FBCYAN}  6.   ${BOLD}卸载通过二进制文件安装的${PLAIN}${FBCYAN}nodejs${PLAIN}"
    echo -e "${BBLACK}------------------------------------------------${PLAIN}"
    echo -e ""
    read -p "Type in the number to choose: " choosen
    case $choosen in
    1)
    #(大概率能)修复CQPS无法启动
        cd "${shloc}/cq-picsearcher-bot/"
        npx pm2 kill
        echo -e "${FBMAGENTA}DONE${PLAIN}"
    ;;
    2)
    #自动备份go-cqhttp日志
        mkdir "${shloc}/go-cqhttp/logs.old/"
        (echo -e "0 * * * * cp -rf ${shloc}/go-cqhttp/logs/* ${shloc}/go-cqhttp/logs.old/" ; crontab -l ) | crontab
        echo -e "${FBMAGENTA}${BOLD}已向 ${PLAIN}crontab -e ${FBMAGENTA}${BOLD}写入 ${PLAIN}${FRED}0 ${FMAGENTA}/* ${FGREEN}* ${FRED}* ${FMAGENTA}* ${FYELLOW}cp -rf ${shloc}/go-cqhttp/logs/* ${shloc}/go-cqhttp/logs.old/${PLAIN}"
        echo -e "${FBMAGENTA}DONE${PLAIN}"
    ;;
    3)
    #启用自动更新config.jsonc
        sed -i 's|"autoUpdateConfig": false,|"autoUpdateConfig": true,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        echo -e "${FBMAGENTA}DONE${PLAIN}"
    ;;
    4)
    #停用自动更新config.jsonc
        sed -i 's|"autoUpdateConfig": true,|"autoUpdateConfig": false,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        echo -e "${FBMAGENTA}DONE${PLAIN}"
    ;;
    5)
    #通过二进制文件安装nodejs
        mkdir "${shloc}/cqps.sh.download/"
        #判断架构
        unamem=$(uname -m)
        echo -e "${FBMAGENTA}系统架构为${unamem}${PLAIN}"
        case $unamem in
        x86_64)
        #amd64
            echo -e "${FBMAGENTA}${BOLD}开始安装${PLAIN}${FBMAGENTA}node-v14.17.3-linux-x64${PLAIN}"
            wget -P "${shloc}/cqps.sh.download/" "https://nodejs.org/dist/v14.17.3/node-v14.17.3-linux-x64.tar.xz"
            xz -d "${shloc}/cqps.sh.download/node-v14.17.3-linux-x64.tar.xz"
            tar -xvf "${shloc}/cqps.sh.download/node-v14.17.3-linux-x64.tar" -C "${shloc}/cqps.sh.download/"
            cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-x64/bin/" "/usr/"
            cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-x64/include/" "/usr/"
            cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-x64/lib/" "/usr/"
            cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-x64/share/" "/usr/"
            rm -rf "${shloc}/cqps.sh.download/"
        ;;
        aarch64)
        #ARMv8
            echo -e "${FBMAGENTA}${BOLD}开始安装${PLAIN}${FBMAGENTA}node-v14.17.3-linux-arm64${PLAIN}"
            wget -P "${shloc}/cqps.sh.download/" "https://nodejs.org/dist/v14.17.3/node-v14.17.3-linux-arm64.tar.xz"
            xz -d "${shloc}/cqps.sh.download/node-v14.17.3-linux-arm64.tar.xz"
            tar -xvf "${shloc}/cqps.sh.download/node-v14.17.3-linux-arm64.tar" -C "${shloc}/cqps.sh.download/"
            cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-arm64/bin/" "/usr/"
            cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-arm64/include/" "/usr/"
            cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-arm64/lib/" "/usr/"
            cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-arm64/share/" "/usr/"
            rm -rf "${shloc}/cqps.sh.download/"
        ;;
        armv7l)
        #ARMv7
            echo -e "${FBMAGENTA}${BOLD}开始安装${PLAIN}${FBMAGENTA}node-v14.17.3-linux-armv7l${PLAIN}"
            wget -P "${shloc}/cqps.sh.download/" "https://nodejs.org/dist/v14.17.3/node-v14.17.3-linux-armv7l.tar.xz"
            xz -d "${shloc}/cqps.sh.download/node-v14.17.3-linux-armv7l.tar.xz"
            tar -xvf "${shloc}/cqps.sh.download/node-v14.17.3-linux-armv7l.tar" -C "${shloc}/cqps.sh.download/"
            cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-armv7l/bin/" "/usr/"
            cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-armv7l/include/" "/usr/"
            cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-armv7l/lib/" "/usr/"
            cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-armv7l/share/" "/usr/"
            rm -rf "${shloc}/cqps.sh.download/"
        ;;
        *)
        #unknown
            echo -e "${FBRED}${BOLD}这是个未知的架构${PLAIN}"
            echo -e "${FBCYAN}${BOLD}请选择所需安装的${PLAIN}${FBCYAN}nodejs${PLAIN}"
            echo -e "${FBCYAN}  1.   x64${PLAIN}"
            echo -e "${FBCYAN}  2.   ARMv8${PLAIN}"
            echo -e "${FBCYAN}  3.   ARMv7${PLAIN}"
            echo -e ""
            read -p "Type in the number to choose: " choosen
            case $choosen in
            1)
            #amd64
                echo -e "${FBMAGENTA}${BOLD}开始安装${PLAIN}${FBMAGENTA}node-v14.17.3-linux-x64${PLAIN}"
                wget -P "${shloc}/cqps.sh.download/" "https://nodejs.org/dist/v14.17.3/node-v14.17.3-linux-x64.tar.xz"
                xz -d "${shloc}/cqps.sh.download/node-v14.17.3-linux-x64.tar.xz"
                tar -xvf "${shloc}/cqps.sh.download/node-v14.17.3-linux-x64.tar" -C "${shloc}/cqps.sh.download/"
                cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-x64/bin/" "/usr/"
                cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-x64/include/" "/usr/"
                cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-x64/lib/" "/usr/"
                cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-x64/share/" "/usr/"
                rm -rf "${shloc}/cqps.sh.download/"
            ;;
            2)
            #ARMv8
                echo -e "${FBMAGENTA}${BOLD}开始安装${PLAIN}${FBMAGENTA}node-v14.17.3-linux-arm64${PLAIN}"
                wget -P "${shloc}/cqps.sh.download/" "https://nodejs.org/dist/v14.17.3/node-v14.17.3-linux-arm64.tar.xz"
                xz -d "${shloc}/cqps.sh.download/node-v14.17.3-linux-arm64.tar.xz"
                tar -xvf "${shloc}/cqps.sh.download/node-v14.17.3-linux-arm64.tar" -C "${shloc}/cqps.sh.download/"
                cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-arm64/bin/" "/usr/"
                cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-arm64/include/" "/usr/"
                cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-arm64/lib/" "/usr/"
                cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-arm64/share/" "/usr/"
                rm -rf "${shloc}/cqps.sh.download/"

            ;;
            3)
            #ARMv7
                echo -e "${FBMAGENTA}${BOLD}开始安装${PLAIN}${FBMAGENTA}node-v14.17.3-linux-armv7l${PLAIN}"
                wget -P "${shloc}/cqps.sh.download/" "https://nodejs.org/dist/v14.17.3/node-v14.17.3-linux-armv7l.tar.xz"
                xz -d "${shloc}/cqps.sh.download/node-v14.17.3-linux-armv7l.tar.xz"
                tar -xvf "${shloc}/cqps.sh.download/node-v14.17.3-linux-armv7l.tar" -C "${shloc}/cqps.sh.download/"
                cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-armv7l/bin/" "/usr/"
                cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-armv7l/include/" "/usr/"
                cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-armv7l/lib/" "/usr/"
                cp -r "${shloc}/cqps.sh.download/node-v14.17.3-linux-armv7l/share/" "/usr/"
                rm -rf "${shloc}/cqps.sh.download/"
            ;;
            esac
        ;;
        esac
        rm -rf "${shloc}/cqps.sh.download/"
        echo -e "${FBMAGENTA}DONE${PLAIN}"
    ;;
    6)
    #卸载通过二进制文件安装的nodejs
        echo -e "${FBMAGENTA}${BOLD}正在卸载${PLAIN}"
        rm -rf "/usr/bin/node"
        rm -rf "/usr/bin/npm"
        rm -rf "/usr/bin/npx"
        rm -rf "/usr/include/node/"
        rm -rf "/usr/lib/node_modules/"
        rm -rf "/usr/share/doc/node/"
        rm -rf "/usr/share/man/man1/node.1"
        rm -rf "/usr/share/systemtap/tapset/node.stp"
        echo -e "${FBMAGENTA}DONE${PLAIN}"
    ;;
    esac
;;
16)
#显示项目信息
    echo -e ""
    echo -e "go-cqhttp"
    echo -e "https://github.com/Mrs4s/go-cqhttp"
    echo -e ""
    echo -e "cq-picsearcher-bot"
    echo -e "https://github.com/Tsuk1ko/cq-picsearcher-bot"
    echo -e ""
    echo -e "cq-picsearcher-bot-deployment"
    echo -e "https://github.com/Miuzarte/cq-picsearcher-bot-deployment"
    echo -e ""
;;
*)
#退出
    exit 1
;;
esac
