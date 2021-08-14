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
shloc="$(cd `dirname $0`; pwd)"    #脚本所在绝对路径${shloc}
lctime="$(date "+%Y年%m月%d日%H时%M分%S秒")"    #脚本启动时时间${lctime}
scrn="gocq"    #go-cqhtto的screen名
#判断包管理器sudo "${pac}" install -y
lsbfile="/etc/lsb-release"
rhfile="/etc/redhat-release"
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
    echo -e "${BOLD}${FBCYAN}Linux发行版判断失败${PLAIN}"
    echo -e "${BOLD}${FBCYAN}请选择当前系统所使用的包管理器${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  1.   apt${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  2.   yum${PLAIN}"
    read -p "Type in the number to choose: " choosen
    case "${choosen}" in
    1)
    #apt
        echo -e "${BOLD}${FBMAGENTA}你选择了apt${PLAIN}"
        pac="apt"
        nodepac="deb"
    ;;
    2)
    #yum
        echo -e "${BOLD}${FBMAGENTA}你选择了yum${PLAIN}"
        pac="yum"
        nodepac="rpm"
    ;;
    *)
    #Default
        echo -e "${BOLD}${FBMAGENTA}?${PLAIN}"
        exit
    ;;
    esac
fi
#基础检测
if
    ! test -f "/bin/curl"
then
    echo -e "${BOLD}${FBMAGENTA}需要安装curl命令！${PLAIN}"
    sudo "${pac}" install -y curl
fi
if
    ! test -f "/bin/wget"
then
    echo -e "${BOLD}${FBMAGENTA}需要安装wget命令！${PLAIN}"
    sudo "${pac}" install -y wget
fi
if
    ! test -f "/bin/git"
then
    echo -e "${BOLD}${FBMAGENTA}需要安装git命令！${PLAIN}"
    sudo "${pac}" install -y git
fi
if
    ! test -f "/bin/screen"
then
    echo -e "${BOLD}${FBMAGENTA}需要安装screen命令！${PLAIN}"
    sudo "${pac}" install -y screen
fi
if
    ! test -f "/bin/crontab"
then
    echo -e "${BOLD}${FBMAGENTA}需要安装crontab命令！${PLAIN}"
    sudo "${pac}" install -y crontab
fi
#判断权限
rootornot="$(id | awk '{print $1}')"
clear
if
    [[ "${rootornot}" = *"id=0"*"root"* ]];
then
    echo -e "${BOLD}${FBGREEN}root${PLAIN}"
else
    echo -e "${BOLD}${FBYELLOW}建议以root身份执行该脚本${PLAIN}"
fi
echo -e "------------------------------------------------"
echo -e "cq-picsearcher-bot 懒人部署&管理脚本${PLAIN}"
echo -e "更新时间 2021/08/15-Sun"
echo -e "https://github.com/Miuzarte/cq-picsearcher-bot-deployment"
echo -e "------------------------------------------------"
echo -e "${BOLD}${FBCYAN}  1.   ${FBGREEN}启动go-cqhttp${PLAIN}"
echo -e "${BOLD}${FBCYAN}  2.   ${FBGREEN}启动CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${BOLD}${FBCYAN}  3.   ${FBRED}关闭go-cqhttp${PLAIN}"
echo -e "${BOLD}${FBCYAN}  4.   ${FBRED}关闭CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${BOLD}${FBCYAN}  5.   ${FBYELLOW}查看go-cqhttp${FBYELLOW}最新日志${PLAIN}"
echo -e "${BOLD}${FBCYAN}  6.   ${FBYELLOW}查看CQPS${FBYELLOW}     最新日志${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${BOLD}${FBCYAN}  7.   ${FBMAGENTA}${FAINT}更新go-cqhttp${PLAIN}"
echo -e "${BOLD}${FBCYAN}  8.   ${FBMAGENTA}更新CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${BOLD}${FBCYAN}  9.   ${FBBLUE}设置go-cqhttp crontab@reboot${FBBLUE}自启${PLAIN}"
echo -e "${BOLD}${FBCYAN}  10.  ${FBBLUE}设置CQPS      crontab@reboot${FBBLUE}自启${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${BOLD}${FBCYAN}  11.  ${FBMAGENTA}部署go-cqhttp${PLAIN}"
echo -e "${BOLD}${FBCYAN}  12.  ${FBMAGENTA}部署CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${BOLD}${FBCYAN}  13.  ${FRED}删除go-cqhttp${PLAIN}"
echo -e "${BOLD}${FBCYAN}  14.  ${FRED}删除CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${BOLD}${FBCYAN}  15.  ${PLAIN}其他选项${PLAIN}"
echo -e "${BOLD}${FBCYAN}  16.  ${PLAIN}显示项目信息${PLAIN}"
echo -e "------------------------------------------------"
echo -e ""
read -p "Type in the number to choose: " choosen
case "${choosen}" in
1)
#启动go-cqhttp
    #判断go-cqhttp进程是否存在
    gcpc="$(ps -ef | grep -w go-cqhttp | grep -v grep | wc -l)"
    if
        [ "${gcpc}" = "0" ]
    then
        screen -S "${scrn}" -X quit
        screen -dmS "${scrn}"
        screen -x -S "${scrn}" -p 0 -X stuff "cd ${shloc}/go-cqhttp/"
        screen -x -S "${scrn}" -p 0 -X stuff '\n'
        screen -x -S "${scrn}" -p 0 -X stuff "./go-cqhttp faststart"
        screen -x -S "${scrn}" -p 0 -X stuff '\n'
        echo -e "${BOLD}${FBMAGENTA}已创建名为${PLAIN}${scrn}${FBMAGENTA}的screen实例并启动go-cqhttp${PLAIN}"
    else
        echo -e "${BOLD}${FBYELLOW}go-cqhttp正在运行中${PLAIN}"
    fi
;;
2)
#启动CQPS
    cd "${shloc}/cq-picsearcher-bot/"
    npm start
    echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
;;
3)
#关闭go-cqhttp
    #判断go-cqhttp进程是否存在
    gcpc="$(ps -ef | grep -w go-cqhttp | grep -v grep | wc -l)"
    if
        [ "${gcpc}" = "0" ]
    then
        echo -e "${BOLD}${FBYELLOW}go-cqhttp没有在运行${PLAIN}"
    else
        killall "go-cqhttp"
        screen -S "${scrn}" -X quit
        echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
    fi
;;
4)
#关闭CQPS
    cd "${shloc}/cq-picsearcher-bot/"
    npm stop
    echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
;;
5)
#查看go-cqhttp最新日志
    #获取最新logs文件名
    logfilename="$(ls -lt ${shloc}/go-cqhttp/logs/ | grep -E 202[0-9]-[0-1][0-9]-[0-3][0-9] | head -1 | awk '{print $9}')"
    echo -e "${BOLD}${FBCYAN}进入之后 'Ctrl + C' 退出${PLAIN}"
    echo -e "${BOLD}${FBGREEN}// 实时更新${PLAIN}"
    echo -e "${BOLD}${FBCYAN}键入想要输出的行数l，留空则l=64${PLAIN}"
    read -p "l=" input
    if
        [ "${input}" = "" ]
    then
        input="64"
    fi
    echo -e "${BOLD}${FBMAGENTA}即将输出${shloc}/go-cqhttp/logs/${logfilename}中最后${input}行日志${PLAIN}"
    sleep 2s
    tail -f -n "${input}" "${shloc}/go-cqhttp/logs/${logfilename}"
;;
6)
#查看CQPS最新日志
    echo -e "${BOLD}${FBCYAN}选择要查看的日志${PLAIN}"
    echo -e "${BOLD}${FBCYAN}进入之后 'Ctrl + C' 退出${PLAIN}"
    echo -e "${BOLD}${FBGREEN}// 实时更新${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  1.   normal.log${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  2.   error.log${PLAIN}"
    read -p "Type in the number to choose: " choosen
    echo -e "${BOLD}${FBCYAN}键入想要输出的行数l，留空则l=64${PLAIN}"
    read -p "l=" input
    if
        [ "${input}" = "" ]
    then
        input="64"
    fi
    case "${choosen}" in
    1)
    #normal.log
        echo -e "${BOLD}${FBMAGENTA}即将输出${shloc}/cq-picsearcher-bot/logs/normal.log中最后${input}行日志${PLAIN}"
        sleep 2s
        tail -f -n "${input}" "${shloc}/cq-picsearcher-bot/logs/normal.log"
    ;;
    2)
    #error.log
        echo -e "${BOLD}${FBMAGENTA}即将输出${shloc}/cq-picsearcher-bot/logs/normal.log中最后${input}行日志${PLAIN}"
        sleep 2s
        tail -f -n "${input}" "${shloc}/cq-picsearcher-bot/logs/error.log"
    ;;
    esac
;;
7)
#更新go-cqhttp
    echo -e "${BOLD}${FBCYAN}https://github.com/Mrs4s/go-cqhttp/releases${PLAIN}"
    echo -e "${BOLD}${FBCYAN}手动更新${PLAIN}"
    echo -e ""
    echo -e "${BOLD}${FBCYAN}或${PLAIN}"
    echo -e ""
    echo -e "${BOLD}${FBCYAN}https://github.com/Miuzarte/cq-picsearcher-bot-deployment/releases${PLAIN}"
    echo -e "${BOLD}${FBCYAN}等待同步${PLAIN}"
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
    echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
;;
9)
#设置go-cqhttp自启
    checkfile="${shloc}/go-cqhttp/"
    if
        test -d "${checkfile}"
    then
        rm -rf "${shloc}/go-cqhttp/gocq@reboot.sh"
        touch "${shloc}/go-cqhttp/gocq@reboot.sh"
        chmod +x "${shloc}/go-cqhttp/gocq@reboot.sh"
        echo "#!/bin/bash" >> "${shloc}/go-cqhttp/gocq@reboot.sh"
        echo "scrn=\"${scrn}\"" >> "${shloc}/go-cqhttp/gocq@reboot.sh"
        echo "screen -dmS \"\${scrn}\"" >> "${shloc}/go-cqhttp/gocq@reboot.sh"
        echo "screen -x -S \"\${scrn}\" -p 0 -X stuff \"cd ${shloc}/go-cqhttp/ && ./go-cqhttp faststart\"" >> "${shloc}/go-cqhttp/gocq@reboot.sh"
        echo "screen -x -S \"\${scrn}\" -p 0 -X stuff '\\n'" >> "${shloc}/go-cqhttp/gocq@reboot.sh"
        (echo -e "@reboot ${shloc}/go-cqhttp/gocq@reboot.sh" ; crontab -l ) | crontab
        echo -e "${BOLD}${FBMAGENTA}已向 ${PLAIN}crontab -e ${FBMAGENTA}写入 ${PLAIN}${FMAGENTA}@reboot ${FYELLOW}${shloc}/go-cqhttp/gocq@reboot.sh${PLAIN}"
        echo -e "${BOLD}${FBYELLOW}在第二次设置自启前请确认已删除 ${PLAIN}${FBYELLOW}crontab -e 内的 ${PLAIN}${FMAGENTA}@reboot ${FYELLOW}${shloc}/go-cqhttp/gocq@reboot.sh${PLAIN}"
    else
        echo -e "${BOLD}${FBRED}go-cqhttp未部署${PLAIN}"
    fi
;;
10)
#设置CQPS自启
    checkfile="${shloc}/cq-picsearcher-bot/"
    if
        test -d "${checkfile}"
    then
        echo -e "${BOLD}${FBMAGENTA}CQPS启动后就会由pm2守护运行${PLAIN}"
        echo -e "${BOLD}${FBMAGENTA}所以说是不需要自启的${PLAIN}"
        echo -e "${BOLD}${FBCYAN}当然你要是真的有这个需求也不是不能设${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  1.   Yes${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  2.   No${PLAIN}"
        read -p "Type in the number to choose: " choosen
        case "${choosen}" in
        1)
        #Yes
            rm -rf "${shloc}/cq-picsearcher-bot/cqps@reboot.sh"
            touch "${shloc}/cq-picsearcher-bot/cqps@reboot.sh"
            chmod +x "${shloc}/cq-picsearcher-bot/cqps@reboot.sh"
            echo "#!/bin/bash" >> "${shloc}/cq-picsearcher-bot/cqps@reboot.sh"
            echo "scrn=\"cqps\${RANDOM}\"" >> "${shloc}/cq-picsearcher-bot/cqps@reboot.sh"
            echo "screen -dmS \"\${scrn}\"" >> "${shloc}/cq-picsearcher-bot/cqps@reboot.sh"
            echo "screen -x -S \"\${scrn}\" -p 0 -X stuff \"cd ${shloc}/cq-picsearcher-bot/ && npm start && exit\"" >> "${shloc}/cq-picsearcher-bot/cqps@reboot.sh"
            echo "screen -x -S \"\${scrn}\" -p 0 -X stuff '\\n'" >> "${shloc}/cq-picsearcher-bot/cqps@reboot.sh"
            (echo -e "@reboot ${shloc}/cq-picsearcher-bot/cqps@reboot.sh" ; crontab -l ) | crontab
            echo -e "${BOLD}${FBMAGENTA}已向 ${PLAIN}crontab -e ${FBMAGENTA}写入 ${PLAIN}${FMAGENTA}@reboot ${FYELLOW}${shloc}/cq-picsearcher-bot/cqps@reboot.sh${PLAIN}"
            echo -e "${BOLD}${FBYELLOW}在第二次设置自启前请确认已删除 ${PLAIN}crontab -e ${FBYELLOW}内的 ${PLAIN}${FMAGENTA}@reboot ${FYELLOW}${shloc}/cq-picsearcher-bot/cqps@reboot.sh${PLAIN}"
        ;;
        2)
        #No
            echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
        ;;
        esac
    else
        echo -e "${BOLD}${FBRED}cq-picsearcher-bot未部署${PLAIN}"
    fi
;;
11)
#部署go-cqhttp
    #判断是否二次部署
    checkfile="${shloc}/go-cqhttp/"
    if
        test -d "${checkfile}"
    then
        mv "${shloc}/go-cqhttp/" "${shloc}/go-cqhttp.old/"
        echo -e "${BOLD}${FBMAGENTA}检测到存在${shloc}/go-cqhttp/文件夹，已备份为${shloc}/go-cqhttp.old/${PLAIN}"
    fi
    mkdir "${shloc}/go-cqhttp/"
    mkdir "${shloc}/cqps.sh.download/"
    #判断架构
    unamem="$(uname -m)"
    echo -e "${BOLD}${FBMAGENTA}系统架构为${unamem}${PLAIN}"
    case "${unamem}" in
    x86_64)
    #amd64
        echo -e "${BOLD}${FBMAGENTA}开始部署go-cqhttp_linux_amd64${PLAIN}"
        wget -P "${shloc}/cqps.sh.download/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta6/go-cqhttp_linux_amd64.tar.gz"
        tar -zxvf "${shloc}/cqps.sh.download/go-cqhttp_linux_amd64.tar.gz" -C "${shloc}/go-cqhttp/"
    ;;
    aarch64)
    #ARMv8
        echo -e "${BOLD}${FBMAGENTA}开始部署go-cqhttp_linux_arm64${PLAIN}"
        wget -P "${shloc}/cqps.sh.download/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta6/go-cqhttp_linux_arm64.tar.gz"
        tar -zxvf "${shloc}/cqps.sh.download/go-cqhttp_linux_arm64.tar.gz" -C "${shloc}/go-cqhttp/"
    ;;
    armv7l)
    #ARMv7
        echo -e "${BOLD}${FBMAGENTA}开始部署go-cqhttp_linux_armv7${PLAIN}"
        wget -P "${shloc}/cqps.sh.download/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta6/go-cqhttp_linux_armv7.tar.gz"
        tar -zxvf "${shloc}/cqps.sh.download/go-cqhttp_linux_armv7.tar.gz" -C "${shloc}/go-cqhttp/"
    ;;
    *)
    #unknown
        echo -e "${BOLD}${FBRED}这是个未知的架构${PLAIN}"
        echo -e "${BOLD}${FBCYAN}请选择所需部署的go-cqhttp${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  1.   amd64${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  2.   ARMv8${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  3.   ARMv7${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  4.   i386${PLAIN}"
        echo -e ""
        read -p "Type in the number to choose: " choosen
        case "${choosen}" in
        1)
        #amd64
            echo -e "${BOLD}${FBMAGENTA}开始部署go-cqhttp_linux_amd64${PLAIN}"
            wget -P "${shloc}/cqps.sh.download/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta6/go-cqhttp_linux_amd64.tar.gz"
            tar -zxvf "${shloc}/cqps.sh.download/go-cqhttp_linux_amd64.tar.gz" -C "${shloc}/go-cqhttp/"
        ;;
        2)
        #ARMv8
            echo -e "${BOLD}${FBMAGENTA}开始部署go-cqhttp_linux_arm64${PLAIN}"
            wget -P "${shloc}/cqps.sh.download/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta6/go-cqhttp_linux_arm64.tar.gz"
            tar -zxvf "${shloc}/cqps.sh.download/go-cqhttp_linux_arm64.tar.gz" -C "${shloc}/go-cqhttp/"
        ;;
        3)
        #ARMv7
            echo -e "${BOLD}${FBMAGENTA}开始部署go-cqhttp_linux_armv7${PLAIN}"
            wget -P "${shloc}/cqps.sh.download/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta6/go-cqhttp_linux_armv7.tar.gz"
            tar -zxvf "${shloc}/cqps.sh.download/go-cqhttp_linux_armv7.tar.gz" -C "${shloc}/go-cqhttp/"
        ;;
        4)
        #i386
            echo -e "${BOLD}${FBMAGENTA}开始部署go-cqhttp_linux_386${PLAIN}"
            wget -P "${shloc}/cqps.sh.download/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta6/go-cqhttp_linux_386.tar.gz"
            tar -zxvf "${shloc}/cqps.sh.download/go-cqhttp_linux_386.tar.gz" -C "${shloc}/go-cqhttp/"
        ;;
        esac
    ;;
    esac
    rm -rf "${shloc}/cqps.sh.download/"
    chmod +x "${shloc}/go-cqhttp/go-cqhttp"
    cd "${shloc}/go-cqhttp/"
    echo -e "${BOLD}${FBCYAN}接下来请选择${PLAIN}"
    echo -e "${BOLD}> 2: 正向 Websocket 通信${PLAIN}"
    echo -e "${BOLD}${FBCYAN}输入一个2之后一共按两次回车${PLAIN}"
    sleep 1s
    ./go-cqhttp faststart
    echo -e "${BOLD}${FBCYAN}项目拉取完毕，是否开始填写 config.yml 基础配置项${PLAIN}"
    echo -e "${BOLD}${FBGREEN}// 输入项无需任何引号${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  1.   Yes${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  2.   No${PLAIN}"
    echo -e ""
    read -p "Type in the number to choose: " choosen
    case "${choosen}" in
    1)
    #Yes
        echo -e "${BOLD}${FBMAGENTA}你选择了Yes${PLAIN}"
        echo -e ""
        #"uin"
        echo -e "${BOLD}${FBCYAN}QQ号${PLAIN}"
        read -p "uin: " input
        sed -i 's|uin: .*|uin: '"${input}"'|' "${shloc}/go-cqhttp/config.yml"
        echo -e ""
        #"password"
        echo -e "${BOLD}${FBCYAN}QQ密码，留空则使用扫码登陆${PLAIN}"
        echo -e "${BOLD}${FBGREEN}// 推荐无密码扫码，有密码的情况下扫码大概率失败${PLAIN}"
        read -p "password: " input
        sed -i 's|password: '.*'|password: '\'''"${input}"''\''|' "${shloc}/go-cqhttp/config.yml"
        echo -e ""
        #"access_token"
        echo -e "${BOLD}${FBCYAN}访问密钥，强烈推荐在公网的服务器设置，可留空${PLAIN}"
        read -p "access_token: " input
        sed -i 's|access-token: '.*'|access-token: '\'''"${input}"''\''|' "${shloc}/go-cqhttp/config.yml"
        echo -e ""
        #"log-level"
        echo -e "${BOLD}${FBCYAN}日志等级${PLAIN}"
        echo -e "${BOLD}${FBCYAN}序号越小信息越多${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  1.   trace${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  2.   debug${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  3.   info(建议)(包含聊天记录)${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  4.   warn(默认)(不含聊天记录)${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  5.   error${PLAIN}"
        read -p "Type in the number to choose: " choosen
        case "${choosen}" in
        1)
        #trace
            sed -i 's|log-level: .*|log-level: trace|' "${shloc}/go-cqhttp/config.yml"
        ;;
        2)
        #debug
            sed -i 's|log-level: .*|log-level: debug|' "${shloc}/go-cqhttp/config.yml"
        ;;
        3)
        #info
            sed -i 's|log-level: .*|log-level: info|' "${shloc}/go-cqhttp/config.yml"
        ;;
        4)
        #warn
            sed -i 's|log-level: .*|log-level: warn|' "${shloc}/go-cqhttp/config.yml"
        ;;
        5)
        #error
            sed -i 's|log-level: .*|log-level: error|' "${shloc}/go-cqhttp/config.yml"
        ;;
        esac
        #"log-aging"
        echo -e "${BOLD}${FBCYAN}日志保留时长${PLAIN}"
        echo -e "${BOLD}${FBGREEN}// 单位天，设置为 0 表示永久保留${PLAIN}"
        read -p "log-aging: " input
        sed -i 's|log-aging: .*|log-aging: '"${input}"'|' "${shloc}/go-cqhttp/config.yml"
        echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
    ;;
    2)
    #No
        echo -e "${BOLD}${FBMAGENTA}你选择了No${PLAIN}"
    ;;
    *)
    #Default
        echo -e "${BOLD}${FBMAGENTA}默认选择No${PLAIN}"
    ;;
    esac
    echo -e "${BOLD}${FBCYAN}部署结束，将进行首次启动验证登录，确认登录成功之后 'Ctrl + C' 退出，然后重新运行脚本选项1${PLAIN}"
    echo -e "${BOLD}${FBCYAN}回车继续${PLAIN}"
    ./go-cqhttp faststart
;;
12)
#部署CQPS
    #判断node
    checkfile="/bin/node"
    if
        test -f "${checkfile}"
    then
        nodever="$(node -v)"
        case "${nodever}" in
        v1[4-9].*)
            echo -e "${BOLD}${FBMAGENTA}当前nodejs版本: ${PLAIN}${nodever}"
        ;;
        *)
            echo -e "${BOLD}${FBMAGENTA}当前nodejs版本: ${PLAIN}${nodever} ${BOLD}${FBMAGENTA}不符合cqps所要求的v14+，开始安装目前的lts版本${PLAIN}"
            curl -fsSL "https://${nodepac}.nodesource.com/setup_lts.x" | sudo bash -
            sudo "${pac}" install -y nodejs
            echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
        ;;
        esac
    else
        curl -fsSL "https://${nodepac}.nodesource.com/setup_lts.x" | sudo bash -
        sudo "${pac}" install -y nodejs
        echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
    fi
    #判断是否二次部署
    checkfile="${shloc}/cq-picsearcher-bot/"
    if
        test -d "${checkfile}"
    then
        mv "${shloc}/cq-picsearcher-bot/" "${shloc}/cq-picsearcher-bot.old/"
        echo -e "${FBMAGENTA}检测到存在${shloc}/cq-picsearcher-bot/文件夹，已备份为${shloc}/cq-picsearcher-bot.old/${PLAIN}"
    fi
    git clone "https://github.com.cnpmjs.org/Tsuk1ko/cq-picsearcher-bot"
    cp "${shloc}/cq-picsearcher-bot/config.default.jsonc" "${shloc}/cq-picsearcher-bot/config.jsonc"
    cd "${shloc}/cq-picsearcher-bot/"
    echo -e ""
    echo -e "${BOLD}${FBCYAN}选择yarn源${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  1.   官方源${FAINT}(海外)${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  2.   阿里镜像源${FAINT}(大陆)${PLAIN}"
    echo -e ""
    read -p "Type in the number to choose: " choosen
    case "${choosen}" in
    1)
    #官方源(海外)
        echo -e "${BOLD}${FBMAGENTA}你选择了官方源${PLAIN}"
        npm i --force -g yarn
        yarn
    ;;
    2)
    #阿里镜像源(大陆)
        echo -e "${BOLD}${FBMAGENTA}你选择了阿里镜像源${PLAIN}"
        npm i --force -g yarn --registry=https://registry.npm.taobao.org
        yarn config set registry https://registry.npm.taobao.org --global
        yarn config set disturl https://npm.taobao.org/dist --global
        yarn
    ;;
    *)
    #Default
        echo -e "${BOLD}${FBMAGENTA}默认选择阿里镜像源${PLAIN}"
        npm i --force -g yarn --registry=https://registry.npm.taobao.org
        yarn config set registry https://registry.npm.taobao.org --global
        yarn config set disturl https://npm.taobao.org/dist --global
        yarn
    ;;
    esac
    echo -e ""
    echo -e "${BOLD}${FBCYAN}项目拉取完毕,是否开始填写 config.jsonc 基础配置项${PLAIN}"
    echo -e "${BOLD}${FBGREEN}// 输入项无需任何引号${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  1.   Yes${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  2.   No${PLAIN}"
    echo -e ""
    read -p "Type in the number to choose: " choosen
    case "${choosen}" in
    1)
    #Yes
        echo -e "${BOLD}${FBMAGENTA}你选择了Yes${PLAIN}"
        echo -e ""
        #"port"
        echo -e "${BOLD}${FBCYAN}go-cqhttp ws端口，留空则保持默认6700${PLAIN}"
        read -p "\"port\": " input
        if
            [ "$input" = "" ]
        then
            echo -e "${BOLD}保持默认(6700)"
        else
            sed -i 's|"port": .*,|"port": '"${input}"',|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        fi
        echo -e ""
        #"accessToken"
        echo -e "${BOLD}${FBCYAN}go-cqhttp 访问密钥，无则留空${PLAIN}"
        read -p "\"accessToken\": " input
        sed -i 's|"accessToken": ".*",|"accessToken": "'"${input}"'",|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        echo -e ""
        #"admin"
        echo -e "${BOLD}${FBCYAN}管理者QQ，必填${PLAIN}"
        read -p "\"admin\": " input
        sed -i 's|"admin": .*,|"admin": '"${input}"',|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        echo -e ""
        #"proxy"
        echo -e "${BOLD}${FBCYAN}大部分请求所使用的代理，留空则不使用代理${PLAIN}"
        echo -e "${BOLD}${FBCYAN}支持 http(s):// 和 socks://${PLAIN}"
        echo -e "${BOLD}${FBGREEN}\"[https(s)/socks]://[IP]:[Port]\"${PLAIN}"
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
        echo -e "${BOLD}${FBCYAN}saucenao APIKEY，必填，否则无法使用 saucenao 搜图，留空则跳过${PLAIN}"
        echo -e "${BOLD}${FBCYAN}前往${PLAIN}"
        echo -e "${BOLD}https://saucenao.com/user.php"
        echo -e "${BOLD}${FBCYAN}注册登录之后${PLAIN}"
        echo -e "${BOLD}${FBCYAN}再到${PLAIN}"
        echo -e "${BOLD}https://saucenao.com/user.php?page=search-api"
        echo -e "${BOLD}${FBCYAN}复制api key${PLAIN}"
        read -p "\"saucenaoApiKey\": " input
        sed -i 's|"saucenaoApiKey": ".*",|"saucenaoApiKey": "'"${input}"'",|' "${shloc}/cq-picsearcher-bot/config.jsonc"
    ;;
    2)
    #No
        echo -e "${BOLD}${FBMAGENTA}你选择了No${PLAIN}"
    ;;
    *)
    #Default
        echo -e "${BOLD}${FBMAGENTA}默认选择No${PLAIN}"
    ;;
    esac
    echo -e "${BOLD}${FBCYAN}是否启用自动更新 config.jsonc${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  1.   true(建议)${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  2.   false(默认)${PLAIN}"
    echo -e ""
    read -p "Type in the number to choose: " choosen
    case "${choosen}" in
    1)
    #true
        sed -i 's|"autoUpdateConfig": false,|"autoUpdateConfig": true,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        echo -e "${BOLD}${FBMAGENTA}你选择了true${PLAIN}"
    ;;
    2)
    #false
        echo -e "${BOLD}${FBMAGENTA}你选择了false${PLAIN}"
    ;;
    *)
    #Default
        echo -e "${BOLD}${FBMAGENTA}默认选择false${PLAIN}"
    ;;
    esac
;;
13)
#删除go-cqhttp
    #判断go-cqhttp进程是否存在
    gcpc=`ps -ef | grep -w go-cqhttp | grep -v grep | wc -l`
    if
        [ "${gcpc}" = "0" ]
    then
        checkfile=${shloc}/go-cqhttp/
        if
            test -d "${checkfile}"
        then
            rm -rf "${shloc}/go-cqhttp/"
            echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
        else
            echo -e "${BOLD}${FBRED}go-cqhttp未部署${PLAIN}"
        fi
    else
        echo -e "${BOLD}${FBYELLOW}go-cqhttp正在运行中${PLAIN}"
    fi
;;
14)
#删除CQPS
    checkfile="${shloc}/cq-picsearcher-bot/"
    if
        test -d "${checkfile}"
    then
        cd "${shloc}/cq-picsearcher-bot/"
        npm stop
        npx pm2 kill
        rm -rf "${shloc}/cq-picsearcher-bot/"
        echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
    else
        echo -e "${BOLD}${FBRED}cq-picsearcher-bot未部署${PLAIN}"
    fi
;;
15)
#其他选项
    clear
    echo -e "${BBLACK}------------------------------------------------${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  1.   (大概率能)修复CQPS无法启动${PLAIN}"
    echo -e "${BBLACK}------------------------------------------------${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  2.   设置go-cqhttp日志等级${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  3.   设置go-cqhttp日志保留时长${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  4.   ${FAINT}(开关)自动备份go-cqhttp日志${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  5.   (开关)自动更新config.jsonc${PLAIN}"
    echo -e "${BBLACK}------------------------------------------------${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  6.   通过二进制文件安装nodejs${PLAIN}"
    echo -e "${BOLD}${FBCYAN}  7.   卸载通过二进制文件安装的nodejs${PLAIN}"
    echo -e "${BBLACK}------------------------------------------------${PLAIN}"
    echo -e ""
    read -p "Type in the number to choose: " choosen
    case "${choosen}" in
    1)
    #(大概率能)修复CQPS无法启动
        cd "${shloc}/cq-picsearcher-bot/"
        npx pm2 kill
        echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
    ;;
    2)
    #设置go-cqhttp日志等级
        echo -e "${BOLD}${FBCYAN}序号越小信息越多${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  1.   trace${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  2.   debug${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  3.   info(建议)(包含聊天记录)${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  4.   warn(默认)(不含聊天记录)${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  5.   error${PLAIN}"
        read -p "Type in the number to choose: " choosen
        case "${choosen}" in
        1)
        #trace
            sed -i 's|log-level: .*|log-level: trace|' "${shloc}/go-cqhttp/config.yml"
        ;;
        2)
        #debug
            sed -i 's|log-level: .*|log-level: debug|' "${shloc}/go-cqhttp/config.yml"
        ;;
        3)
        #info
            sed -i 's|log-level: .*|log-level: info|' "${shloc}/go-cqhttp/config.yml"
        ;;
        4)
        #warn
            sed -i 's|log-level: .*|log-level: warn|' "${shloc}/go-cqhttp/config.yml"
        ;;
        5)
        #error
            sed -i 's|log-level: .*|log-level: error|' "${shloc}/go-cqhttp/config.yml"
        ;;
        esac
        echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
    ;;
    3)
    #设置go-cqhttp日志保留时长
        echo -e "${BOLD}${FBGREEN}// 单位天，设置为 0 表示永久保留${PLAIN}"
        read -p "log-aging: " input
        sed -i 's|log-aging: .*|log-aging: '"${input}"'|' "${shloc}/go-cqhttp/config.yml"
        echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
    ;;
    4)
    #自动备份go-cqhttp日志
        echo -e "${BOLD}${FBMAGENTA}这是一个已弃用的功能${PLAIN}"
        echo -e "${BOLD}${FBMAGENTA}go-cqhttp v1.0.0-beta6可以设置永久保留日志${PLAIN}"
        echo -e "${BOLD}${FBCYAN}当然你要是真的有这个需求也不是不能设${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  1.   Enable${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  2.   Disable${PLAIN}"
        read -p "Type in the number to choose: " choosen
        case "${choosen}" in
        1)
        #Enable
            mkdir "${shloc}/go-cqhttp/logs.old/"
            touch "/etc/cron.hourly/gocqlogs.sh"
            chmod +x "/etc/cron.hourly/gocqlogs.sh"
            echo -e "cp -rf ${shloc}/go-cqhttp/logs/* ${shloc}/go-cqhttp/logs.old/" >> "/etc/cron.hourly/gocqlogs.sh"
            echo -e "${BOLD}${FBMAGENTA}系统将会每小时把${shloc}/go-cqhttp/logs/内的文件复制到${shloc}/go-cqhttp/logs.old/${PLAIN}"
            echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
        ;;
        2)
        #Disable
            rm -f "/etc/cron.hourly/gocqlogs.sh"
            echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
        ;;
        esac
    ;;
    5)
    #自动更新config.jsonc
        echo -e "${BOLD}${FBCYAN}  1.   Enable${PLAIN}"
        echo -e "${BOLD}${FBCYAN}  2.   Disable${PLAIN}"
        read -p "Type in the number to choose: " choosen
        case "${choosen}" in
        1)
        #Enable
            sed -i 's|"autoUpdateConfig": false,|"autoUpdateConfig": true,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
            echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
        ;;
        2)
        #Disable
            sed -i 's|"autoUpdateConfig": true,|"autoUpdateConfig": false,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
            echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
        ;;
        esac
    ;;
    6)
    #通过二进制文件安装nodejs
        mkdir "${shloc}/cqps.sh.download/"
        #判断架构
        unamem="$(uname -m)"
        echo -e "${BOLD}${FBMAGENTA}系统架构为${unamem}${PLAIN}"
        case "${unamem}" in
        x86_64)
        #amd64
            echo -e "${FBMAGENTA}开始安装node-v14.17.3-linux-x64${PLAIN}"
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
            echo -e "${FBMAGENTA}开始安装node-v14.17.3-linux-arm64${PLAIN}"
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
            echo -e "${FBMAGENTA}开始安装node-v14.17.3-linux-armv7l${PLAIN}"
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
            echo -e "${BOLD}${FBRED}这是个未知的架构${PLAIN}"
            echo -e "${BOLD}${FBCYAN}请选择所需安装的nodejs${PLAIN}"
            echo -e "${BOLD}${FBCYAN}  1.   x64${PLAIN}"
            echo -e "${BOLD}${FBCYAN}  2.   ARMv8${PLAIN}"
            echo -e "${BOLD}${FBCYAN}  3.   ARMv7${PLAIN}"
            echo -e ""
            read -p "Type in the number to choose: " choosen
            case "${choosen}" in
            1)
            #amd64
                echo -e "${FBMAGENTA}开始安装node-v14.17.3-linux-x64${PLAIN}"
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
                echo -e "${FBMAGENTA}开始安装node-v14.17.3-linux-arm64${PLAIN}"
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
                echo -e "${FBMAGENTA}开始安装node-v14.17.3-linux-armv7l${PLAIN}"
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
        echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
    ;;
    7)
    #卸载通过二进制文件安装的nodejs
        echo -e "${FBMAGENTA}正在卸载${PLAIN}"
        rm -rf "/usr/bin/node"
        rm -rf "/usr/bin/npm"
        rm -rf "/usr/bin/npx"
        rm -rf "/usr/include/node/"
        rm -rf "/usr/lib/node_modules/"
        rm -rf "/usr/share/doc/node/"
        rm -rf "/usr/share/man/man1/node.1"
        rm -rf "/usr/share/systemtap/tapset/node.stp"
        echo -e "${BOLD}${FBMAGENTA}DONE${PLAIN}"
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
    exit
;;
esac
