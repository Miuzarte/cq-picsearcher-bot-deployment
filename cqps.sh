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
scrn="gocq"    #go-cqhttp的screen名
echoE() {   #转义echo
    echo -e "${BOLD}${1}${2}${3}${4}${PLAIN}"
}
readP() {   #输入
    read -p "${1}" ${2}
}
agmwait() { #参数执行等待
    if
        [ "${agmornot}" = "1" ]
    then
        echoE ${FBMAGENTA} "将在2s后执行"
        sleep 2s
    fi
}
network() {  #网络连通性
    echoE ${FBCYAN} "本机网络是否会经过Great Firewall？"
    echoE ${FBCYAN} "  1.   Yes"
    echoE ${FBCYAN} "  2.   No"
    readP "Type in the number to choose: " choosen
    case "${choosen}" in
    1)
    #Yes
        echoYES1
        giturl="hub.fastgit.org"
        yarnsource="ALI"
        echoE ${FBCYAN} "出现无法搜图、搜图结果无图片等情况时，请先检查gocq、cqps的日志再去cqps仓库发起discuss"
    ;;
    2)
    #No
        echoNO1
        giturl="github.com"
        yarnsource="DF"
    ;;
    *)
    #Yes
        echoYES2
        giturl="hub.fastgit.org"
        yarnsource="ALI"
        echoE ${FBCYAN} "出现无法搜图、搜图结果无图片等情况时，请先检查gocq、cqps的日志再去cqps仓库发起discuss"
    ;;
    esac
}
gocqDL() {  #go-cqhttp下载
    gocqver="v1.0.0-rc1"
    echoE ${FBMAGENTA} "开始部署go-cqhttp_linux_${1}"
    mkdir "${shloc}/cqps.sh.download/"
    wget -P "${shloc}/cqps.sh.download/" "https://${giturl}//Mrs4s/go-cqhttp/releases/download/${gocqver}/go-cqhttp_linux_${1}.tar.gz"
    mkdir "${shloc}/go-cqhttp/"
    tar -zxvf "${shloc}/cqps.sh.download/go-cqhttp_linux_${1}.tar.gz" -C "${shloc}/go-cqhttp/"
    rm -rf "${shloc}/cqps.sh.download/"
}
logSED() {  #log等级设置
    sed -i 's|log-level: .*|log-level: '"${1}"'|' "${shloc}/go-cqhttp/config.yml"
}
nodejsIns() {    #nodejs安装
    curl -sL https://${nodepac}.nodesource.com/setup_14.x | sudo bash -
    sudo "${pac}" install -y nodejs
}
nodejsDL() {    #nodejs下载
    nodejsver="v14.19.3"
    echoE ${FBMAGENTA} "开始安装node-${nodejsver}-linux-${1}"
    mkdir "${shloc}/cqps.sh.download/"
    wget -P "${shloc}/cqps.sh.download/" "https://nodejs.org/dist/${nodejsver}/node-${nodejsver}-linux-${1}.tar.xz"
    xz -d "${shloc}/cqps.sh.download/node-${nodejsver}-linux-${1}.tar.xz"
    tar -xvf "${shloc}/cqps.sh.download/node-${nodejsver}-linux-${1}.tar" -C "${shloc}/cqps.sh.download/"
    cp -r "${shloc}/cqps.sh.download/node-${nodejsver}-linux-${1}/bin/" "/usr/"
    cp -r "${shloc}/cqps.sh.download/node-${nodejsver}-linux-${1}/include/" "/usr/"
    cp -r "${shloc}/cqps.sh.download/node-${nodejsver}-linux-${1}/lib/" "/usr/"
    cp -r "${shloc}/cqps.sh.download/node-${nodejsver}-linux-${1}/share/" "/usr/"
    rm -rf "${shloc}/cqps.sh.download/"
}
yarnDF() {  #海外yarn
    npm i --force -g yarn
    yarn
}
yarnALI() { #阿里yarn
    npm i --force -g yarn --registry=https://registry.npm.taobao.org
    yarn config set registry https://registry.npm.taobao.org --global
    yarn config set disturl https://npm.taobao.org/dist --global
    yarn
}
echoDONE() {    #DONE
    echoE ${FBMAGENTA} "DONE"
}
echoYES1() {    #你选择了Yes
    echoE ${FBMAGENTA} "你选择了Yes"
}
echoYES2() {    #默认选择Yes
    echoE ${FBMAGENTA} "默认选择Yes"
}
echoNO1() {    #你选择了No
    echoE ${FBMAGENTA} "你选择了No"
}
echoNO2() {    #默认选择No
    echoE ${FBMAGENTA} "默认选择No"
}
echoTRUE1() {   #你选择了True
    echoE ${FBMAGENTA} "你选择了True"
}
echoFALSE1() {  #你选择了False
    echoE ${FBMAGENTA} "你选择了False"
}
echoFALSE2() {  #默认选择False
    echoE ${FBMAGENTA} "默认选择False"
}
#判断包管理器sudo "${pac}" install -y
lsbfile="/etc/lsb-release"
rhfile="/etc/redhat-release"
if
    test -f "${lsbfile}"
then
    pac="apt"
    nodepac="deb"
elif
    test -f "${rhfile}"
then
    pac="yum"
    nodepac="rpm"
else
    echoE ${FBCYAN} "Linux发行版判断失败"
    echoE ${FBCYAN} "请选择当前系统所使用的包管理器"
    echoE ${FBCYAN} "  1.   apt"
    echoE ${FBCYAN} "  2.   yum"
    readP "Type in the number to choose: " choosen
    case "${choosen}" in
    1)
    #apt
        echoE ${FBMAGENTA} "你选择了apt"
        pac="apt"
        nodepac="deb"
    ;;
    2)
    #yum
        echoE ${FBMAGENTA} "你选择了yum"
        pac="yum"
        nodepac="rpm"
    ;;
    *)
    #Default
        echoE ${FBMAGENTA} "?"
        exit
    ;;
    esac
fi
#基础检测
if
    ! test -f "/bin/curl"
then
    echoE ${FBMAGENTA} "需要安装curl命令！"
    sudo "${pac}" install -y curl
fi
if
    ! test -f "/bin/wget"
then
    echoE ${FBMAGENTA} "需要安装wget命令！"
    sudo "${pac}" install -y wget
fi
if
    ! test -f "/bin/git"
then
    echoE ${FBMAGENTA} "需要安装git命令！"
    sudo "${pac}" install -y git
fi
if
    ! test -f "/bin/screen"
then
    echoE ${FBMAGENTA} "需要安装screen命令！"
    sudo "${pac}" install -y screen
fi
if
    ! test -f "/bin/crontab"
then
    echoE ${FBMAGENTA} "需要安装crontab命令！"
    sudo "${pac}" install -y crontab
fi
if
    [ "${1}" = "" ]
then
    #判断权限
    rootornot="$(id | awk '{print $1}')"
    checkfile="${shloc}/cq-picsearcher-bot/"
    clear
    if
        [[ "${rootornot}" = *"id=0"*"root"* ]];
    then
        echoE ${FBGREEN} "root"
    else
        echoE ${FBYELLOW} "安装时建议以root身份执行该脚本"
    fi
    echoE ${lctime}
    echoE "------------------------------------------------"
    echoE "cq-picsearcher-bot 懒人部署&管理脚本"
    echoE "更新时间 2022/2/14-Mon"
    echoE "https://github.com/Miuzarte/cq-picsearcher-bot-deployment"
    echoE "------------------------------------------------"
    echoE ${FBCYAN} "  1.   ${FBGREEN}启动go-cqhttp"
    echoE ${FBCYAN} "  2.   ${FBGREEN}启动CQPS"
    echoE ${FBLACK} "------------------------------------------------"
    echoE ${FBCYAN} "  3.   ${FBRED}关闭go-cqhttp"
    echoE ${FBCYAN} "  4.   ${FBRED}关闭CQPS"
    echoE ${FBLACK} "------------------------------------------------"
    echoE ${FBCYAN} "  5.   ${FBYELLOW}查看go-cqhttp${FBYELLOW}最新日志"
    echoE ${FBCYAN} "  6.   ${FBYELLOW}查看CQPS${FBYELLOW}     最新日志"
    echoE ${FBLACK} "------------------------------------------------"
    echoE ${FBCYAN} "  7.   ${FBMAGENTA}${FAINT}更新go-cqhttp"
    echoE ${FBCYAN} "  8.   ${FBMAGENTA}更新CQPS"
    echoE ${FBLACK} "------------------------------------------------"
    echoE ${FBCYAN} "  9.   ${FBBLUE}设置go-cqhttp crontab@reboot${FBBLUE}自启"
    echoE ${FBCYAN} "  10.  ${FBBLUE}设置CQPS      crontab@reboot${FBBLUE}自启"
    echoE ${FBLACK} "------------------------------------------------"
    echoE ${FBCYAN} "  11.  ${FBMAGENTA}部署go-cqhttp"
    echoE ${FBCYAN} "  12.  ${FBMAGENTA}部署CQPS"
    echoE ${FBLACK} "------------------------------------------------"
    echoE ${FBCYAN} "  13.  ${FRED}删除go-cqhttp"
    echoE ${FBCYAN} "  14.  ${FRED}删除CQPS"
    echoE ${FBLACK} "------------------------------------------------"
    echoE ${FBCYAN} "  15.  其他选项"
    echoE ${FBCYAN} "  16.  显示项目信息"
    echoE "------------------------------------------------"
    if
        test -d "${checkfile}"
    then
        pm2 list
    fi
    readP "Type in the number to choose: " choosen
else
    if
        ! [[ "${1}" =~ ^[1-8]$|^1[5-6]$ ]]
    then
        echoE ${FBRED} "为防止误触发 参数执行仅支持选项1-8,15-16!"
    else
        choosen="${1}"
        agmornot="1"
    fi
fi
case "${choosen}" in
1)
#启动go-cqhttp
    #判断go-cqhttp进程是否存在
    gcpc="$(ps -ef | grep -w go-cqhttp | grep -v grep | wc -l)"
    if
        [ "${gcpc}" = "0" ]
    then
        echoE ${FBMAGENTA} "启动go-cqhttp"
        agmwait
        screen -S "${scrn}" -X quit
        screen -dmS "${scrn}"
        screen -x -S "${scrn}" -p 0 -X stuff "cd ${shloc}/go-cqhttp/"
        screen -x -S "${scrn}" -p 0 -X stuff '\n'
        screen -x -S "${scrn}" -p 0 -X stuff "./go-cqhttp faststart"
        screen -x -S "${scrn}" -p 0 -X stuff '\n'
        echoE ${FBMAGENTA} "已创建名为${scrn}${FBMAGENTA}的screen实例并启动go-cqhttp"
    else
        echoE ${FBYELLOW} "go-cqhttp正在运行中"
    fi
;;
2)
#启动CQPS
    echoE ${FBMAGENTA} "启动CQPS"
    agmwait
    cd "${shloc}/cq-picsearcher-bot/"
    npm start
    echoDONE
;;
3)
#关闭go-cqhttp
    #判断go-cqhttp进程是否存在
    gcpc="$(ps -ef | grep -w go-cqhttp | grep -v grep | wc -l)"
    if
        [ "${gcpc}" = "0" ]
    then
        echoE ${FBYELLOW} "go-cqhttp没有在运行"
    else
        echoE ${FBMAGENTA} "关闭go-cqhttp"
        agmwait
        killall "go-cqhttp"
        screen -S "${scrn}" -X quit
        echoDONE
    fi
;;
4)
#关闭CQPS
    echoE ${FBMAGENTA} "关闭CQPS"
    agmwait
    cd "${shloc}/cq-picsearcher-bot/"
    npm stop
    echoDONE
;;
5)
#查看go-cqhttp最新日志
    #获取最新logs文件名
    logfilename="$(ls -lt ${shloc}/go-cqhttp/logs/ | grep -E 202[0-9]-[0-1][0-9]-[0-3][0-9] | head -1 | awk '{print $9}')"
    echoE ${FBCYAN} "进入之后 'Ctrl + C' 退出"
    echoE ${FBGREEN} "// 实时更新"
    echoE ${FBCYAN} "键入想要输出的行数l，留空则l=64"
    readP "l=" input
    if
        [ "${input}" = "" ]
    then
        input="64"
    fi
    echoE ${FBMAGENTA} "即将输出${shloc}/go-cqhttp/logs/${logfilename}中最后${input}行日志"
    sleep 2s
    tail -f -n "${input}" "${shloc}/go-cqhttp/logs/${logfilename}"
;;
6)
#查看CQPS最新日志
    echoE ${FBCYAN} "选择要查看的日志"
    echoE ${FBCYAN} "进入之后 'Ctrl + C' 退出"
    echoE ${FBGREEN} "// 实时更新"
    echoE ${FBCYAN} "  1.   normal.log"
    echoE ${FBCYAN} "  2.   error.log"
    readP "Type in the number to choose: " choosen
    echoE ${FBCYAN} "键入想要输出的行数l，留空则l=64"
    readP "l=" input
    if
        [ "${input}" = "" ]
    then
        input="64"
    fi
    case "${choosen}" in
    1)
    #normal.log
        echoE ${FBMAGENTA} "即将输出${shloc}/cq-picsearcher-bot/logs/normal.log中最后${input}行日志"
        sleep 2s
        tail -f -n "${input}" "${shloc}/cq-picsearcher-bot/logs/normal.log"
    ;;
    2)
    #error.log
        echoE ${FBMAGENTA} "即将输出${shloc}/cq-picsearcher-bot/logs/normal.log中最后${input}行日志"
        sleep 2s
        tail -f -n "${input}" "${shloc}/cq-picsearcher-bot/logs/error.log"
    ;;
    esac
;;
7)
#更新go-cqhttp
    echoE ${FBCYAN} "https://github.com/Mrs4s/go-cqhttp/releases"
    echoE ${FBCYAN} "手动更新"
    echoE ""
    echoE ${FBCYAN} "或"
    echoE ""
    echoE ${FBCYAN} "https://github.com/Miuzarte/cq-picsearcher-bot-deployment/releases"
    echoE ${FBCYAN} "等待同步"
;;
8)
#更新CQPS
    cd "${shloc}/cq-picsearcher-bot/"
    npm stop
    git fetch --all
    git reset --hard origin/master
    git pull
    npm start
    echoDONE
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
        echoE ${FBMAGENTA} "已向 crontab -e ${FBMAGENTA}写入 ${FMAGENTA}@reboot ${FYELLOW}${shloc}/go-cqhttp/gocq@reboot.sh"
        echoE ${FBYELLOW} "在第二次设置自启前请确认已删除 ${FBYELLOW}crontab -e 内的 ${FMAGENTA}@reboot ${FYELLOW}${shloc}/go-cqhttp/gocq@reboot.sh"
    else
        echoE ${FBRED} "go-cqhttp未部署"
    fi
;;
10)
#设置CQPS自启
    checkfile="${shloc}/cq-picsearcher-bot/"
    if
        test -d "${checkfile}"
    then
        echoE ${FBMAGENTA} "CQPS启动后就会由pm2守护运行"
        echoE ${FBMAGENTA} "所以说是不需要自启的"
        echoE ${FBCYAN} "当然你要是真的有这个需求也不是不能设"
        echoE ${FBCYAN} "  1.   Yes"
        echoE ${FBCYAN} "  2.   No"
        readP "Type in the number to choose: " choosen
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
            echoE ${FBMAGENTA} "已向 crontab -e ${FBMAGENTA}写入 ${FMAGENTA}@reboot ${FYELLOW}${shloc}/cq-picsearcher-bot/cqps@reboot.sh"
            echoE ${FBYELLOW} "在第二次设置自启前请确认已删除 crontab -e ${FBYELLOW}内的 ${FMAGENTA}@reboot ${FYELLOW}${shloc}/cq-picsearcher-bot/cqps@reboot.sh"
        ;;
        2)
        #No
            echoDONE
        ;;
        esac
    else
        echoE ${FBRED} "cq-picsearcher-bot未部署"
    fi
;;
11)
#部署go-cqhttp
    rm -rf "${shloc}/cqps.sh.download/"
    #判断是否二次部署
    checkfile="${shloc}/go-cqhttp/"
    if
        test -d "${checkfile}"
    then
        echoE ${FBMAGENTA} "检测到存在${shloc}/go-cqhttp/文件夹，已备份为${shloc}/go-cqhttp.old/"
        mv "${shloc}/go-cqhttp/" "${shloc}/go-cqhttp.old/"
    fi
    network
    #判断架构
    unamem="$(uname -m)"
    echoE ${FBMAGENTA} "系统架构为${unamem}"
    case "${unamem}" in
    x86_64)
    #amd64
        gocqDL amd64
    ;;
    aarch64)
    #ARMv8
        gocqDL arm64
    ;;
    armv7l)
    #ARMv7
        gocqDL armv7
    ;;
    *)
    #unknown
        echoE ${FBRED} "这是个未知的架构"
        echoE ${FBCYAN} "请选择所需部署的go-cqhttp"
        echoE ${FBCYAN} "  1.   amd64"
        echoE ${FBCYAN} "  2.   ARMv8"
        echoE ${FBCYAN} "  3.   ARMv7"
        echoE ""
        readP "Type in the number to choose: " choosen
        case "${choosen}" in
        1)
        #amd64
            gocqDL amd64
        ;;
        2)
        #ARMv8
            gocqDL arm64
        ;;
        3)
        #ARMv7
            gocqDL armv7
        ;;
        esac
    ;;
    esac
    chmod +x "${shloc}/go-cqhttp/go-cqhttp"
    cd "${shloc}/go-cqhttp/"
    echoE ${FBCYAN} "接下来请选择"
    echoE "> 2: 正向 Websocket 通信"
    echoE ${FBCYAN} "输入一个2之后一共按两次回车"
    sleep 1s
    ./go-cqhttp faststart
    echoE ${FBCYAN} "项目拉取完毕，是否开始填写 config.yml 基础配置项"
    echoE ${FBGREEN} "// 输入项无需任何引号"
    echoE ${FBCYAN} "  1.   Yes"
    echoE ${FBCYAN} "  2.   No"
    echoE ""
    readP "Type in the number to choose: " choosen
    case "${choosen}" in
    1)
    #Yes
        echoYES1
        echoE ""
        #"uin"
        echoE ${FBCYAN} "QQ号"
        readP "uin: " input
        sed -i 's|uin: .*|uin: '"${input}"'|' "${shloc}/go-cqhttp/config.yml"
        echoE ""
        #"password"
        echoE ${FBCYAN} "QQ密码，留空则使用扫码登陆"
        echoE ${FBGREEN} "// 推荐无密码扫码，有密码的情况下扫码大概率失败"
        readP "password: " input
        sed -i 's|password: '.*'|password: '\'''"${input}"''\''|' "${shloc}/go-cqhttp/config.yml"
        echoE ""
        #"access_token"
        echoE ${FBCYAN} "访问密钥，强烈推荐在公网的服务器设置，可留空"
        readP "access_token: " input
        sed -i 's|access-token: '.*'|access-token: '\'''"${input}"''\''|' "${shloc}/go-cqhttp/config.yml"
        echoE ""
        #"log-level"
        echoE ${FBCYAN} "日志等级"
        echoE ${FBCYAN} "序号越小信息越多"
        echoE ${FBCYAN} "  1.   trace"
        echoE ${FBCYAN} "  2.   debug"
        echoE ${FBCYAN} "  3.   info(建议)(包含聊天记录)"
        echoE ${FBCYAN} "  4.   warn(默认)(不含聊天记录)"
        echoE ${FBCYAN} "  5.   error"
        readP "Type in the number to choose: " choosen
        case "${choosen}" in
        1)
        #trace
            logSED trace
        ;;
        2)
        #debug
            logSED debug
        ;;
        3)
        #info
            logSED info
        ;;
        4)
        #warn
            logSED warn
        ;;
        5)
        #error
            logSED error
        ;;
        esac
        #"log-aging"
        echoE ${FBCYAN} "日志保留时长"
        echoE ${FBGREEN} "// 单位天，设置为 0 表示永久保留"
        readP "log-aging: " input
        sed -i 's|log-aging: .*|log-aging: '"${input}"'|' "${shloc}/go-cqhttp/config.yml"
        echoDONE
    ;;
    2)
    #No
        echoNO1
    ;;
    *)
    #Default
        echoNO2
    ;;
    esac
    echoE ${FBCYAN} "部署结束，将进行首次启动验证登录，确认登录成功之后 'Ctrl + C' 退出，然后重新运行\"./cqps.sh 1\""
    echoE ${FBCYAN} "回车继续"
    ./go-cqhttp faststart
;;
12)
#部署CQPS
    rm -rf "${shloc}/cqps.sh.download/"
    #判断node
    checkfile="/bin/node"
    if
        test -f "${checkfile}"
    then
        nodever="$(node -v)"
        echoE ${FBMAGENTA} "当前nodejs版本: ${nodever}"
        case "${nodever}" in
        v14.*)
            echoE ${FBGREEN} "OK"
        ;;
        *)
            echoE ${FBCYAN} "建议的版本是v14.x，是否覆盖安装当前版本？"
            echoE ${FBCYAN} "  1.   Yes"
            echoE ${FBCYAN} "  2.   继续使用当前nodejs版本"
            echoE ""
            readP "Type in the number to choose: " choosen
            case "${choosen}" in
            1)
            #Yes
                echoYES1
                nodejsIns
            ;;
            *)
            #No
                echoNO1
            ;;
            esac
            echoDONE
        ;;
        esac
    else
        nodejsIns
        echoDONE
    fi
    #判断是否二次部署
    checkfile="${shloc}/cq-picsearcher-bot/"
    if
        test -d "${checkfile}"
    then
        mv "${shloc}/cq-picsearcher-bot/" "${shloc}/cq-picsearcher-bot.old/"
        echoE ${FBMAGENTA} "检测到存在${shloc}/cq-picsearcher-bot/文件夹，已备份为${shloc}/cq-picsearcher-bot.old/"
    fi
    network
    git clone "https://${giturl}/Tsuk1ko/cq-picsearcher-bot"
    cp "${shloc}/cq-picsearcher-bot/config.default.jsonc" "${shloc}/cq-picsearcher-bot/config.jsonc"
    cd "${shloc}/cq-picsearcher-bot/"
    case "${yarnsource}" in
    ALI)
    #阿里镜像源(大陆)
        yarnALI
    ;;
    DF)
    #官方源(海外)
        yarnDF
    ;;
    esac
    echoE ""
    echoE ${FBCYAN} "项目拉取完毕,是否开始填写 config.jsonc 基础配置项"
    echoE ${FBGREEN} "// 输入项无需任何引号"
    echoE ${FBCYAN} "  1.   Yes"
    echoE ${FBCYAN} "  2.   No"
    echoE ""
    readP "Type in the number to choose: " choosen
    case "${choosen}" in
    1)
    #Yes
        echoYES1
        echoE ""
        #"port"
        echoE ${FBCYAN} "go-cqhttp ws端口，留空则保持默认6700"
        readP "\"port\": " input
        if
            [ "$input" = "" ]
        then
            echoE "保持默认(6700)"
        else
            sed -i 's|"port": .*,|"port": '"${input}"',|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        fi
        echoE ""
        #"accessToken"
        echoE ${FBCYAN} "go-cqhttp 访问密钥，无则留空"
        readP "\"accessToken\": " input
        sed -i 's|"accessToken": ".*",|"accessToken": "'"${input}"'",|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        echoE ""
        #"admin"
        echoE ${FBCYAN} "管理者QQ，必填"
        readP "\"admin\": " input
        sed -i 's|"admin": .*,|"admin": '"${input}"',|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        echoE ""
        #"proxy"
        echoE ${FBCYAN} "大部分请求所使用的代理，留空则不使用代理"
        echoE ${FBCYAN} "支持 http(s):// 和 socks://"
        echoE ${FBGREEN} "\"[https(s)/socks]://[IP]:[Port]\""
        readP "\"proxy\": " input
        if
            [ "input" = "" ]
        then
            echoE "保持默认(不使用代理)"
        else
            sed -i 's|"proxy": ".*",|"proxy": "'"${input}"'",|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        fi
        echoE ""
        #"saucenaoApiKey"
        echoE ${FBCYAN} "saucenao APIKEY，必填，否则无法使用 saucenao 搜图，留空则跳过"
        echoE ${FBCYAN} "前往"
        echoE "https://saucenao.com/user.php"
        echoE ${FBCYAN} "注册登录之后"
        echoE ${FBCYAN} "再到"
        echoE "https://saucenao.com/user.php?page=search-api"
        echoE ${FBCYAN} "复制api key"
        readP "\"saucenaoApiKey\": " input
        sed -i 's|"saucenaoApiKey": ".*",|"saucenaoApiKey": "'"${input}"'",|' "${shloc}/cq-picsearcher-bot/config.jsonc"
    ;;
    2)
    #No
        echoNO1
    ;;
    *)
    #Default
        echoNO2
    ;;
    esac
    echoE ${FBCYAN} "是否启用自动更新 config.jsonc"
    echoE ${FBCYAN} "  1.   true(建议)"
    echoE ${FBCYAN} "  2.   false(默认)"
    echoE ""
    readP "Type in the number to choose: " choosen
    case "${choosen}" in
    1)
    #true
        sed -i 's|"autoUpdateConfig": false,|"autoUpdateConfig": true,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        echoTRUE1
    ;;
    2)
    #false
        echoFALSE1
    ;;
    *)
    #Default
        echoFALSE2
    ;;
    esac
    echoDONE
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
            echoDONE
        else
            echoE ${FBRED} "go-cqhttp未部署"
        fi
    else
        echoE ${FBYELLOW} "go-cqhttp正在运行中"
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
        echoDONE
    else
        echoE ${FBRED} "cq-picsearcher-bot未部署"
    fi
;;
15)
#其他选项
    clear
    echoE ${FBBLACK} "------------------------------------------------"
    echoE ${FBCYAN} "  1.   (大概率能)修复CQPS无法启动"
    echoE ${FBBLACK} "------------------------------------------------"
    echoE ${FBCYAN} "  2.   设置go-cqhttp日志等级"
    echoE ${FBCYAN} "  3.   设置go-cqhttp日志保留时长"
    echoE ${FBCYAN} "  4.   ${FAINT}(开关)自动备份go-cqhttp日志"
    echoE ${FBCYAN} "  5.   (开关)自动更新config.jsonc"
    echoE ${FBBLACK} "------------------------------------------------"
    echoE ${FBCYAN} "  6.   通过二进制文件安装nodejs"
    echoE ${FBCYAN} "  7.   卸载通过二进制文件安装的nodejs"
    echoE ${FBBLACK} "------------------------------------------------"
    echoE ""
    readP "Type in the number to choose: " choosen
    case "${choosen}" in
    1)
    #(大概率能)修复CQPS无法启动
        cd "${shloc}/cq-picsearcher-bot/"
        npx pm2 kill
        echoDONE
    ;;
    2)
    #设置go-cqhttp日志等级
        echoE ${FBCYAN} "序号越小信息越多"
        echoE ${FBCYAN} "  1.   trace"
        echoE ${FBCYAN} "  2.   debug"
        echoE ${FBCYAN} "  3.   info(建议)(包含聊天记录)"
        echoE ${FBCYAN} "  4.   warn(默认)(不含聊天记录)"
        echoE ${FBCYAN} "  5.   error"
        readP "Type in the number to choose: " choosen
        case "${choosen}" in
        1)
        #trace
            logSED trace
        ;;
        2)
        #debug
            logSED debug
        ;;
        3)
        #info
            logSED info
        ;;
        4)
        #warn
            logSED warn
        ;;
        5)
        #error
            logSED error
        ;;
        esac
        echoDONE
    ;;
    3)
    #设置go-cqhttp日志保留时长
        echoE ${FBGREEN} "// 单位天，设置为 0 表示永久保留"
        readP "log-aging: " input
        sed -i 's|log-aging: .*|log-aging: '"${input}"'|' "${shloc}/go-cqhttp/config.yml"
        echoDONE
    ;;
    4)
    #自动备份go-cqhttp日志
        echoE ${FBMAGENTA} "这是一个已弃用的功能"
        echoE ${FBMAGENTA} "目前go-cqhttp可以设置永久保留日志"
        echoE ${FBCYAN} "当然你要是真的有这个需求也不是不能设"
        echoE ${FBCYAN} "  1.   Enable"
        echoE ${FBCYAN} "  2.   Disable"
        readP "Type in the number to choose: " choosen
        case "${choosen}" in
        1)
        #Enable
            mkdir "${shloc}/go-cqhttp/logs.old/"
            touch "/etc/cron.hourly/gocqlogs.sh"
            chmod +x "/etc/cron.hourly/gocqlogs.sh"
            echo -e "cp -rf ${shloc}/go-cqhttp/logs/* ${shloc}/go-cqhttp/logs.old/" >> "/etc/cron.hourly/gocqlogs.sh"
            echoE ${FBMAGENTA} "系统将会每小时把${shloc}/go-cqhttp/logs/内的文件复制到${shloc}/go-cqhttp/logs.old/"
            echoDONE
        ;;
        2)
        #Disable
            rm -f "/etc/cron.hourly/gocqlogs.sh"
            echoDONE
        ;;
        esac
    ;;
    5)
    #自动更新config.jsonc
        echoE ${FBCYAN} "  1.   Enable"
        echoE ${FBCYAN} "  2.   Disable"
        readP "Type in the number to choose: " choosen
        case "${choosen}" in
        1)
        #Enable
            sed -i 's|"autoUpdateConfig": false,|"autoUpdateConfig": true,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
            echoDONE
        ;;
        2)
        #Disable
            sed -i 's|"autoUpdateConfig": true,|"autoUpdateConfig": false,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
            echoDONE
        ;;
        esac
    ;;
    6)
    #通过二进制文件安装nodejs
        #判断架构
        unamem="$(uname -m)"
        echoE ${FBMAGENTA} "系统架构为${unamem}"
        case "${unamem}" in
        x86_64)
        #amd64
            nodejsDL x64
        ;;
        aarch64)
        #ARMv8
            nodejsDL arm64
        ;;
        armv7l)
        #ARMv7
            nodejsDL armv7l
        ;;
        *)
        #unknown
            echoE ${FBRED} "这是个未知的架构"
            echoE ${FBCYAN} "请选择所需安装的nodejs"
            echoE ${FBCYAN} "  1.   x64"
            echoE ${FBCYAN} "  2.   ARMv8"
            echoE ${FBCYAN} "  3.   ARMv7"
            echoE ""
            readP "Type in the number to choose: " choosen
            case "${choosen}" in
            1)
            #amd64
                nodejsDL x64
            ;;
            2)
            #ARMv8
                nodejsDL arm64

            ;;
            3)
            #ARMv7
                nodejsDL armv7l
            ;;
            esac
        ;;
        esac
        echoDONE
    ;;
    7)
    #卸载通过二进制文件安装的nodejs
        echoE ${FBMAGENTA} "正在卸载"
        rm -rf "/usr/bin/node"
        rm -rf "/usr/bin/npm"
        rm -rf "/usr/bin/npx"
        rm -rf "/usr/include/node/"
        rm -rf "/usr/lib/node_modules/"
        rm -rf "/usr/share/doc/node/"
        rm -rf "/usr/share/man/man1/node.1"
        rm -rf "/usr/share/systemtap/tapset/node.stp"
        echoDONE
    ;;
    esac
;;
16)
#显示项目信息
    echoE ""
    echoE "go-cqhttp"
    echoE "https://github.com/Mrs4s/go-cqhttp"
    echoE ""
    echoE "cq-picsearcher-bot"
    echoE "https://github.com/Tsuk1ko/cq-picsearcher-bot"
    echoE ""
    echoE "cq-picsearcher-bot-deployment"
    echoE "https://github.com/Miuzarte/cq-picsearcher-bot-deployment"
    echoE ""
;;
*)
#退出
    exit
;;
esac
