#!/bin/bash
BLACK="\033[30m"        #黑色${BLACK}
RED="\033[31m"          #红色${RED}
GREEN="\033[32m"        #绿色${GREEN}
YELLOW="\033[33m"       #黄色${YELLOW}
BLUE="\033[34m"         #蓝色${BLUE}
MAGENTA="\033[35m"      #洋红色${MAGENTA}
CYAN="\033[36m"         #青色${CYAN}
WHITE="\033[37m"        #灰色${WHITE}
PLAIN="\033[0m"         #白色${PLAIN}
BBLACK="\033[90m"       #亮黑色${BBLACK}
BRED="\033[91m"         #亮红色${BRED}
BGREEN="\033[92m"       #亮绿色${BGREEN}
BYELLOW="\033[93m"      #亮黄色${BYELLOW}
BBLUE="\033[94m"        #亮蓝色${BBLUE}
BMAGENTA="\033[95m"     #亮洋红色${BMAGENTA}
BCYAN="\033[96m"        #亮青色${BCYAN}
BWHITE="\033[97m"       #亮灰色${BWHITE}
shloc=$(cd `dirname $0`; pwd)   #脚本所在绝对路径${shloc}
time=$(date "+%Y年%m月%d日的%H时%M分%S秒")   #脚本启动时时间${time}
clear
echo -e "------------------------------------------------"
echo -e "cq-picsearcher-bot 懒人脚本"
echo -e "更新时间 2021/05/29-Sat"
echo -e "这个垃圾脚本需要的注意事项:"
echo -e "大部分操作还是需要阅读我之前写的部署教程"
echo -e "https://github.com/Miuzarte/cq-picsearcher-bot-deployment"
echo -e "go-cqhttp/和cq-picsearcher-bot/文件夹会生成在脚本的当前目录"
echo -e "自启动用的全是crontab -e @reboot"
echo -e "自启动如果写入crontab -e失败也不会报错"
echo -e "执行部署CQPSor更新CQPS之后设定的git镜像站不会恢复"
echo -e "------------------------------------------------"
echo -e "${BCYAN}  1.   ${BGREEN}启动${PLAIN}go-cqhttp${PLAIN}"
echo -e "${BCYAN}  2.   ${BGREEN}启动${PLAIN}CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${BCYAN}  3.   ${BRED}关闭${PLAIN}go-cqhttp${PLAIN}"
echo -e "${BCYAN}  4.   ${BRED}关闭${PLAIN}CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${BCYAN}  5.   ${BYELLOW}查看${PLAIN}go-cqhttp${BYELLOW}日志${PLAIN}"
echo -e "${BCYAN}  6.   ${BYELLOW}查看${PLAIN}CQPS${BYELLOW}     日志${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${BCYAN}  7.   ${BMAGENTA}更新${PLAIN}go-cqhttp${PLAIN}"
echo -e "${BCYAN}  8.   ${BMAGENTA}更新${PLAIN}CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${BCYAN}  9.   ${BBLUE}设置${PLAIN}go-cqhttp crontab@reboot${BBLUE}自启${PLAIN}"
echo -e "${BCYAN}  10.  ${BBLUE}设置${PLAIN}CQPS      crontab@reboot${BBLUE}自启${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${BCYAN}  11.  ${BMAGENTA}部署${PLAIN}go-cqhttp${PLAIN}"
echo -e "${BCYAN}  12.  ${BMAGENTA}部署${PLAIN}CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${BCYAN}  13.  ${RED}删除${PLAIN}go-cqhttp${PLAIN}"
echo -e "${BCYAN}  14.  ${RED}删除${PLAIN}CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "${BCYAN}  15.  ${PLAIN}其他选项${PLAIN}"
echo -e "${BCYAN}  16.  ${PLAIN}显示项目信息${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e ""
read -p "请选择：" choose
case $choose in
1)
#启动go-cqhttp
    #判断go-cqhttp进程是否存在
    gcst=`ps -ef |grep -w go-cqhttp|grep -v grep|wc -l`
    if
        [ $gcst = 0 ]
    then
        screen_name=$"gocq"
        cmd1=$"cd ${shloc}/go-cqhttp/"
        cmd2=$"./go-cqhttp faststart"
        screen -dmS $screen_name
        screen -x -S $screen_name -p 0 -X stuff "$cmd1"
        screen -x -S $screen_name -p 0 -X stuff $'\n'
        screen -x -S $screen_name -p 0 -X stuff "$cmd2"
        screen -x -S $screen_name -p 0 -X stuff $'\n'
        echo -e "${BMAGENTA}已创建名为"gocq"的screen并启动go-cqhttp${PLAIN}"
    else
        echo -e "${BYELLOW}go-cqhttp正在运行中${PLAIN}"
    fi
;;
2)
#启动CQPS
    clear
    cd "${shloc}/cq-picsearcher-bot/"
    npm start
    echo -e "${MAGENTA}DONE${PLAIN}"
;;
3)
#关闭go-cqhttp
    #判断go-cqhttp进程是否存在
    gcst=`ps -ef |grep -w go-cqhttp|grep -v grep|wc -l`
    if
        [ $gcst = 0 ]
    then
        echo -e "${BYELLOW}go-cqhttp没有在运行${PLAIN}"
    else
        pkill -P go-cqhttp
        screen -S gocq -X quit
    fi
    echo -e "${MAGENTA}DONE${PLAIN}"
;;
4)
#关闭CQPS
    clear
    cd "${shloc}/cq-picsearcher-bot/"
    npm stop
    echo -e "${MAGENTA}DONE${PLAIN}"
;;
5)
#查看go-cqhttp日志
    #判断go-cqhttp进程是否存在
    gcst=`ps -ef |grep -w go-cqhttp|grep -v grep|wc -l`
    if
        [ $gcst = 0 ]
    then
        echo -e "${BYELLOW}go-cqhttp没有在运行${PLAIN}"
    else
        echo -e "${BCYAN}进入之后 'Ctrl + A + D' 退出${PLAIN}"
        echo -e "${BCYAN}回车继续${PLAIN}"
        read -p ""
        screen -r gocq
    fi
;;
6)
#查看CQPS日志
    cd "${shloc}/cq-picsearcher-bot/"
    echo -e "${BCYAN}进入之后 'Ctrl + C' 退出${PLAIN}"
    echo -e "${BCYAN}回车继续${PLAIN}"
    read -p ""
    npm run log
;;
7)
#更新go-cqhttp
    echo -e "${BCYAN}https://github.com/Mrs4s/go-cqhttp/releases${PLAIN}"
    echo -e "${BCYAN}请${PLAIN}"
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
    echo -e "${MAGENTA}DONE${PLAIN}"
;;
9)
#设置go-cqhttp自启
    checkfile=${shloc}/go-cqhttp
    if
        test -d "$checkfile"
    then
        rm -rf ${shloc}/go-cqhttp/boottask
        mkdir ${shloc}/go-cqhttp/boottask
        touch ${shloc}/go-cqhttp/boottask/gocq.sh
        chmod 700 ${shloc}/go-cqhttp/boottask/gocq.sh
        echo "#!/bin/bash" >> ${shloc}/go-cqhttp/boottask/gocq.sh
        echo "screen_name=$\"gocq\"" >> ${shloc}/go-cqhttp/boottask/gocq.sh
        echo "cmd1=$\"cd ${shloc}/go-cqhttp/\"" >> ${shloc}/go-cqhttp/boottask/gocq.sh
        echo "cmd2=$\"./go-cqhttp faststart\"" >> ${shloc}/go-cqhttp/boottask/gocq.sh
        echo "screen -dmS \$screen_name" >> ${shloc}/go-cqhttp/boottask/gocq.sh
        echo "screen -x -S \$screen_name -p 0 -X stuff \"\$cmd1\"" >> ${shloc}/go-cqhttp/boottask/gocq.sh
        echo "screen -x -S \$screen_name -p 0 -X stuff $'\\n'" >> ${shloc}/go-cqhttp/boottask/gocq.sh
        echo "screen -x -S \$screen_name -p 0 -X stuff \"\$cmd2\"" >> ${shloc}/go-cqhttp/boottask/gocq.sh
        echo "screen -x -S \$screen_name -p 0 -X stuff $'\\n'" >> ${shloc}/go-cqhttp/boottask/gocq.sh
        (echo -e "@reboot ${shloc}/go-cqhttp/boottask/gocq.sh" ; crontab -l ) | crontab
        echo -e "${BMAGENTA}已向 crontab -e 写入 @reboot ${shloc}/go-cqhttp/boottask/gocq.sh${PLAIN}"
        echo -e "${BYELLOW}在第二次设置自启前请确认已将crontab -e内的${MAGENTA}@reboot ${YELLOW}${shloc}/go-cqhttp/boottask/gocq.sh${BYELLOW}删除${PLAIN}"
    else
        echo -e "${BRED}未部署go-cqhttp${PLAIN}"
    fi
;;
10)
#设置CQPS自启
    checkfile=${shloc}/cq-picsearcher-bot
    if
        test -d "$checkfile"
    then
        rm -rf ${shloc}/cq-picsearcher-bot/boottask
        mkdir ${shloc}/cq-picsearcher-bot/boottask
        touch ${shloc}/cq-picsearcher-bot/boottask/cqps.sh
        chmod 700 ${shloc}/cq-picsearcher-bot/boottask/cqps.sh
        echo "#!/bin/bash" >> ${shloc}/cq-picsearcher-bot/boottask/cqps.sh
        echo "screen_name=$\"CQPS\"" >> ${shloc}/cq-picsearcher-bot/boottask/cqps.sh
        echo "cmd1=$\"cd ${shloc}/cq-picsearcher-bot/\"" >> ${shloc}/cq-picsearcher-bot/boottask/cqps.sh
        echo "cmd2=$\"npm start\"" >> ${shloc}/cq-picsearcher-bot/boottask/cqps.sh
        echo "cmd3=$\"exit\"" >> ${shloc}/cq-picsearcher-bot/boottask/cqps.sh
        echo "screen -dmS \$screen_name" >> ${shloc}/cq-picsearcher-bot/boottask/cqps.sh
        echo "screen -x -S \$screen_name -p 0 -X stuff \"\$cmd1\"" >> ${shloc}/cq-picsearcher-bot/boottask/cqps.sh
        echo "screen -x -S \$screen_name -p 0 -X stuff $'\\n'" >> ${shloc}/cq-picsearcher-bot/boottask/cqps.sh
        echo "screen -x -S \$screen_name -p 0 -X stuff \"\$cmd2\"" >> ${shloc}/cq-picsearcher-bot/boottask/cqps.sh
        echo "screen -x -S \$screen_name -p 0 -X stuff $'\\n'" >> ${shloc}/cq-picsearcher-bot/boottask/cqps.sh
        echo "screen -x -S \$screen_name -p 0 -X stuff \"\$cmd3\"" >> ${shloc}/cq-picsearcher-bot/boottask/cqps.sh
        echo "screen -x -S \$screen_name -p 0 -X stuff $'\\n'" >> ${shloc}/cq-picsearcher-bot/boottask/cqps.sh
        (echo -e "@reboot ${shloc}/cq-picsearcher-bot/boottask/cqps.sh" ; crontab -l ) | crontab
        echo -e "${BMAGENTA}已向 crontab -e 写入 @reboot ${shloc}/cq-picsearcher-bot/boottask/cqps.sh${PLAIN}"
        echo -e "${BYELLOW}在第二次设置自启前请确认已将crontab -e内的${MAGENTA}@reboot ${YELLOW}${shloc}/cq-picsearcher-bot/boottask/cqps.sh${BYELLOW}删除${PLAIN}"
    else
        echo -e "${BRED}未部署cq-picsearcher-bot${PLAIN}"
    fi
;;
11)
#部署go-cqhttp
    #判断是否二次部署
    checkfile=${shloc}/go-cqhttp/
    if
        test -d "$checkfile"
    then
        mv "${shloc}/go-cqhttp/" "${shloc}/go-cqhttp.old/"
        echo -e "${BMAGENTA}检测到存在${shloc}/go-cqhttp/文件夹,已备份为${shloc}/go-cqhttp.old/${PLAIN}"
    fi
    mkdir "${shloc}/go-cqhttp/"
    #判断架构
    unamem=$(uname -m)
    echo -e "${BMAGENTA}系统架构为${unamem}${PLAIN}"
    case $unamem in
    x86_64)
    #amd64
        echo -e "${BMAGENTA}开始部署go-cqhttp_linux_amd64${PLAIN}"
        wget -P "${shloc}/gocqhttpdownload/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta4/go-cqhttp_linux_amd64.tar.gz"
        tar -zxvf "${shloc}/gocqhttpdownload/go-cqhttp_linux_amd64.tar.gz" -C "${shloc}/go-cqhttp/"
    ;;
    aarch64)
    #ARMv8
        echo -e "${BMAGENTA}开始部署go-cqhttp_linux_arm64${PLAIN}"
        wget -P "${shloc}/gocqhttpdownload/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta4/go-cqhttp_linux_arm64.tar.gz"
        tar -zxvf "${shloc}/gocqhttpdownload/go-cqhttp_linux_arm64.tar.gz" -C "${shloc}/go-cqhttp/"
    ;;
    armv7l)
    #ARMv7
        echo -e "${BMAGENTA}开始部署go-cqhttp_linux_armv7${PLAIN}"
        wget -P "${shloc}/gocqhttpdownload/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta4/go-cqhttp_linux_armv7.tar.gz"
        tar -zxvf "${shloc}/gocqhttpdownload/go-cqhttp_linux_armv7.tar.gz" -C "${shloc}/go-cqhttp/"
    ;;
    *)
    #unknown
        echo -e "${BRED}这是个未知的架构${PLAIN}"
        echo -e "${BCYAN}请选择所需部署的go-cqhttp${PLAIN}"
        echo -e "${BCYAN}  1.   amd64${PLAIN}"
        echo -e "${BCYAN}  2.   ARMv8${PLAIN}"
        echo -e "${BCYAN}  3.   ARMv7${PLAIN}"
        echo -e "${BCYAN}  4.   i386${PLAIN}"
        echo -e ""
        read -p "请选择：" choose
        case $choose in
        1)
        #amd64
            echo -e "${BMAGENTA}开始部署go-cqhttp_linux_amd64${PLAIN}"
            wget -P "${shloc}/gocqhttpdownload/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta4/go-cqhttp_linux_amd64.tar.gz"
            tar -zxvf "${shloc}/gocqhttpdownload/go-cqhttp_linux_amd64.tar.gz" -C "${shloc}/go-cqhttp/"
        ;;
        2)
        #ARMv8
            echo -e "${BMAGENTA}开始部署go-cqhttp_linux_arm64${PLAIN}"
            wget -P "${shloc}/gocqhttpdownload/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta4/go-cqhttp_linux_arm64.tar.gz"
            tar -zxvf "${shloc}/gocqhttpdownload/go-cqhttp_linux_arm64.tar.gz" -C "${shloc}/go-cqhttp/"
        ;;
        3)
        #ARMv7
            echo -e "${BMAGENTA}开始部署go-cqhttp_linux_armv7${PLAIN}"
            wget -P "${shloc}/gocqhttpdownload/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta4/go-cqhttp_linux_armv7.tar.gz"
            tar -zxvf "${shloc}/gocqhttpdownload/go-cqhttp_linux_armv7.tar.gz" -C "${shloc}/go-cqhttp/"
        ;;
        4)
        #i386
            echo -e "${BMAGENTA}开始部署go-cqhttp_linux_386${PLAIN}"
            wget -P "${shloc}/gocqhttpdownload/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v1.0.0-beta4/go-cqhttp_linux_386.tar.gz"
            tar -zxvf "${shloc}/gocqhttpdownload/go-cqhttp_linux_386.tar.gz" -C "${shloc}/go-cqhttp/"
        ;;
        esac
    ;;
    esac
    rm -rf "${shloc}/gocqhttpdownload/"
    chmod 700 "${shloc}/go-cqhttp/go-cqhttp"
    cd "${shloc}/go-cqhttp/"
    echo -e "${BCYAN}接下来请选择${PLAIN}"
    echo -e "${BCYAN}2: 正向 Websocket 通信${PLAIN}"
    ./go-cqhttp faststart
    echo -e "${BCYAN}项目拉取完毕,是否开始填写 config.yml 基础配置项${PLAIN}"
    echo -e "${BGREEN}// 输入项无需任何引号${PLAIN}"
    echo -e "${BCYAN}  1.   Yes${PLAIN}"
    echo -e "${BCYAN}  2.   No${PLAIN}"
    echo -e ""
    read -p "请选择：" choose
    case $choose in
    1)
    #Yes
        echo -e "${MAGENTA}你选择了Yes${PLAIN}"
        echo -e ""
        #"uin"
        echo -e "${BCYAN}QQ号${PLAIN}"
        read -p "uin: " input
        sed -i 's|uin: .*|uin: '"${input}"'|' "${shloc}/go-cqhttp/config.yml"
        echo -e ""
        #"password"
        echo -e "${BCYAN}QQ密码，留空则使用扫码登陆${PLAIN}"
        read -p "password: " input
        sed -i 's|password: '.*'|password: '\'''"${input}"''\''|' "${shloc}/go-cqhttp/config.yml"
        echo -e ""
        #"access_token"
        echo -e "${BCYAN}访问密钥, 强烈推荐在公网的服务器设置，可留空${PLAIN}"
        read -p "access_token: " input
        sed -i 's|access-token: '.*'|access-token: '\'''"${input}"''\''|' "${shloc}/go-cqhttp/config.yml"
        echo -e ""
        echo -e "${MAGENTA}DONE${PLAIN}"
    ;;
    2)
    #No
        echo -e "${MAGENTA}默认选择No${PLAIN}"
        echo -e "${MAGENTA}DONE${PLAIN}"
    ;;
    *)
    #No
        echo -e "${MAGENTA}你选择了No${PLAIN}"
        echo -e "${MAGENTA}DONE${PLAIN}"
    ;;
    esac
;;
12)
#部署CQPS
    #判断发行版
    ubtfile=/etc/lsb-release
    centfile=/etc/redhat-release
    if
        test -f "$ubtfile"
    then
        apt install -y git screen
        curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
        apt install -y nodejs
    elif
        test -f "$centfile"
    then
        yum install -y git screen
        curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash -
        yum install -y nodejs
    else
        echo -e "${BRED}警告: Linux发行版判断失败${PLAIN}"
        echo -e "${BRED}将不会安装git,screen,nodejs${PLAIN}"
        echo -e "${BCYAN}可在主菜单的其它选项中通过二进制文件安装nodejs${PLAIN}"
        echo -e "${BCYAN}脚本已暂停${PLAIN}"
        echo -e "${BCYAN}' Ctrl + C '可取消部署${PLAIN}"
        echo -e "${BCYAN}回车则继续部署${PLAIN}"
        read -p ""
        echo -e "${BRED}请再次确认系统已安装nodejs${PLAIN}"
        echo -e "${BCYAN}回车继续${PLAIN}"
        read -p ""
    fi
    #判断是否二次部署
    checkfile=${shloc}/cq-picsearcher-bot/
    if
        test -d "$checkfile"
    then
        mv "${shloc}/cq-picsearcher-bot/" "${shloc}/cq-picsearcher-bot.old/"
        echo -e "${BMAGENTA}检测到存在${shloc}/cq-picsearcher-bot/文件夹,已备份为${shloc}/cq-picsearcher-bot.old/${PLAIN}"
    fi
        git clone "https://github.com.cnpmjs.org/Tsuk1ko/cq-picsearcher-bot"
        cp "${shloc}/cq-picsearcher-bot/config.default.jsonc" "${shloc}/cq-picsearcher-bot/config.jsonc"
        cd "${shloc}/cq-picsearcher-bot/"
    echo -e ""
    echo -e "${BCYAN}选择yarn源${PLAIN}"
    echo -e "${BCYAN}  1.   官方源(海外)${PLAIN}"
    echo -e "${BCYAN}  2.   阿里镜像源(大陆)${PLAIN}"
    echo -e ""
    read -p "请选择：" choose
    case $choose in
    1)
    #官方源(海外)
        echo -e "${MAGENTA}你选择了官方源${PLAIN}"
        npm i --force -g yarn
        yarn
    ;;
    2)
    #阿里镜像源(大陆)
        echo -e "${MAGENTA}你选择了阿里镜像源${PLAIN}"
        npm i --force -g yarn --registry=https://registry.npm.taobao.org
        yarn config set registry https://registry.npm.taobao.org --global
        yarn config set disturl https://npm.taobao.org/dist --global
        yarn
    ;;
    *)
    #默认阿里
        echo -e "${MAGENTA}默认选择阿里镜像源${PLAIN}"
        npm i --force -g yarn --registry=https://registry.npm.taobao.org
        yarn config set registry https://registry.npm.taobao.org --global
        yarn config set disturl https://npm.taobao.org/dist --global
        yarn
    ;;
    esac
    echo -e ""
    echo -e "${BCYAN}项目拉取完毕,是否开始填写 config.jsonc 基础配置项${PLAIN}"
    echo -e "${BGREEN}// 输入项无需任何引号${PLAIN}"
    echo -e "${BCYAN}  1.   Yes${PLAIN}"
    echo -e "${BCYAN}  2.   No${PLAIN}"
    echo -e ""
    read -p "请选择：" choose
    case $choose in
    1)
    #Yes
        echo -e "${MAGENTA}你选择了Yes${PLAIN}"
        echo -e ""
        #"autoUpdateConfig"
        echo -e "${BCYAN}是否启用自动更新 config.jsonc${PLAIN}"
        echo -e "${BCYAN}  1.   true${PLAIN}(建议)"
        echo -e "${BCYAN}  2.   false${PLAIN}(默认)"
        echo -e ""
        read -p "请选择：" choose
        case $choose in
        1)
        #true
            echo -e "${MAGENTA}你选择了true${PLAIN}"
            sed -i 's|"autoUpdateConfig": false,|"autoUpdateConfig": true,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        ;;
        2)
        #false
            echo -e "${MAGENTA}你选择了false${PLAIN}"
        ;;
        *)
        #false
            echo -e "${MAGENTA}默认选择false${PLAIN}"
        ;;
        esac
        echo -e ""
        #"port"
        echo -e "${BCYAN}go-cqhttp ws端口，留空则保持默认6700${PLAIN}"
        read -p "\"port\": " input
        if
            [ "$input" = "" ]
        then
            echo -e "保持默认(6700)"
        else
            sed -i 's|"port": .*,|"port": '"${input}"',|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        fi
        echo -e ""
        #"accessToken"
        echo -e "${BCYAN}go-cqhttp 访问密钥，无则留空${PLAIN}"
        read -p "\"accessToken\": " input
        sed -i 's|"accessToken": ".*",|"accessToken": "'"${input}"'",|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        echo -e ""
        #"admin"
        echo -e "${BCYAN}管理者QQ，必填${PLAIN}"
        read -p "\"admin\": " input
        sed -i 's|"admin": .*,|"admin": '"${input}"',|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        echo -e ""
        #"proxy"
        echo -e "${BCYAN}大部分请求所使用的代理，留空则不使用代理${PLAIN}"
        echo -e "${BCYAN}支持 http(s):// 和 socks://${PLAIN}"
        echo -e "${BGREEN}\"[https(s)/socks]://[IP]:[Port]\"${PLAIN}"
        read -p "\"proxy\": " input
        if
            [ "input" = "" ]
        then
            echo -e "保持默认(不使用代理)"
        else
            sed -i 's|"proxy": ".*",|"proxy": "'"${input}"'",|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        fi
        echo -e ""
        #"saucenaoApiKey"
        echo -e "${BCYAN}saucenao APIKEY，必填，否则无法使用 saucenao 搜图，留空则跳过${PLAIN}"
        echo -e "${BCYAN}前往${PLAIN}"
        echo -e "https://saucenao.com/user.php"
        echo -e "${BCYAN}注册登录之后${PLAIN}"
        echo -e "${BCYAN}再到${PLAIN}"
        echo -e "https://saucenao.com/user.php?page=search-api"
        echo -e "${BCYAN}复制api key${PLAIN}"
        read -p "\"saucenaoApiKey\": " input
        sed -i 's|"saucenaoApiKey": ".*",|"saucenaoApiKey": "'"${input}"'",|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        echo -e "${MAGENTA}DONE${PLAIN}"
    ;;
    *)
    #No
        echo -e "${MAGENTA}你选择了No${PLAIN}"
        echo -e "${BCYAN}是否启用自动更新config.jsonc${PLAIN}"
        echo -e "${BCYAN}  1.   true${PLAIN}(建议)"
        echo -e "${BCYAN}  2.   false${PLAIN}(默认)"
        echo -e ""
        read -p "请选择：" choose
        case $choose in
        1)
        #true
            sed -i 's|"autoUpdateConfig": false,|"autoUpdateConfig": true,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
            echo -e "${MAGENTA}你选择了true${PLAIN}"
        ;;
        2)
        #false
            echo -e "${MAGENTA}你选择了false${PLAIN}"
        ;;
        *)
        #false
            echo -e "${MAGENTA}默认选择false${PLAIN}"
        ;;
        esac
        echo -e "${MAGENTA}DONE${PLAIN}"
    ;;
    esac
;;
13)
#删除go-cqhttp
    #判断go-cqhttp进程是否存在
    gcst=`ps -ef |grep -w go-cqhttp|grep -v grep|wc -l`
    if
        [ $gcst = 0 ]
    then
        checkfile=${shloc}/go-cqhttp/
        if
            test -d "$checkfile"
        then
            rm -rf "${shloc}/go-cqhttp/"
        else
            echo -e "${BRED}未部署go-cqhttp"
        fi
    else
        echo -e "go-cqhttp正在运行中${PLAIN}"
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
        echo -e "${BRED}未部署cq-picsearcher-bot"
    fi
;;
15)
#其他选项
    clear
    echo -e "${BBLACK}------------------------------------------------${PLAIN}"
    echo -e "${BCYAN}  1.   (也许能)修复CQPS无法启动"
    echo -e "${BBLACK}------------------------------------------------${PLAIN}"
    echo -e "${BCYAN}  2.   启用自动更新config.jsonc"
    echo -e "${BCYAN}  3.   停用自动更新config.jsonc"
    echo -e "${BBLACK}------------------------------------------------${PLAIN}"
    echo -e "${BCYAN}  4.   通过二进制文件安装nodejs"
    echo -e "${BCYAN}  5.   卸载通过二进制文件安装的nodejs"
    echo -e "${BBLACK}------------------------------------------------${PLAIN}"
    echo -e ""
    read -p "请选择：" choose
    case $choose in
    1)
    #(也许能)修复CQPS无法启动
        cd "${shloc}/cq-picsearcher-bot/"
        npx pm2 kill
        echo -e "${MAGENTA}DONE${PLAIN}"
    ;;
    2)
    #启用自动更新config.jsonc
        sed -i 's|"autoUpdateConfig": false,|"autoUpdateConfig": true,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        echo -e "${MAGENTA}DONE${PLAIN}"
    ;;
    3)
    #停用自动更新config.jsonc
        sed -i 's|"autoUpdateConfig": true,|"autoUpdateConfig": false,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
        echo -e "${MAGENTA}DONE${PLAIN}"
    ;;
    4)
    #通过二进制文件安装nodejs
        #判断架构
        unamem=$(uname -m)
        echo -e "${BMAGENTA}系统架构为${unamem}4${PLAIN}"
        case $unamem in
        x86_64)
        #amd64
            echo -e "${BMAGENTA}开始安装node-v14.17.0-linux-x64${PLAIN}"
            mkdir "${shloc}/nodejsdownload/"
            wget -P "${shloc}/nodejsdownload/" "https://nodejs.org/dist/v14.17.0/node-v14.17.0-linux-x64.tar.xz"
            xz -d "${shloc}/nodejsdownload/node-v14.17.0-linux-x64.tar.xz"
            tar -xvf "${shloc}/nodejsdownload/node-v14.17.0-linux-x64.tar" -C "${shloc}/nodejsdownload/"
            cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-x64/bin/" "/usr/"
            cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-x64/include/" "/usr/"
            cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-x64/lib/" "/usr/"
            cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-x64/share/" "/usr/"
        ;;
        aarch64)
        #ARMv8
            echo -e "${BMAGENTA}开始安装node-v14.17.0-linux-arm64${PLAIN}"
            mkdir "${shloc}/nodejsdownload/"
            wget -P "${shloc}/nodejsdownload/" "https://nodejs.org/dist/v14.17.0/node-v14.17.0-linux-arm64.tar.xz"
            xz -d "${shloc}/nodejsdownload/node-v14.17.0-linux-arm64.tar.xz"
            tar -xvf "${shloc}/nodejsdownload/node-v14.17.0-linux-arm64.tar" -C "${shloc}/nodejsdownload/"
            cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-arm64/bin/" "/usr/"
            cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-arm64/include/" "/usr/"
            cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-arm64/lib/" "/usr/"
            cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-arm64/share/" "/usr/"
        ;;
        armv7l)
        #ARMv7
            echo -e "${BMAGENTA}开始安装node-v14.17.0-linux-armv7l${PLAIN}"
            mkdir "${shloc}/nodejsdownload/"
            wget -P "${shloc}/nodejsdownload/" "https://nodejs.org/dist/v14.17.0/node-v14.17.0-linux-armv7l.tar.xz"
            xz -d "${shloc}/nodejsdownload/node-v14.17.0-linux-armv7l.tar.xz"
            tar -xvf "${shloc}/nodejsdownload/node-v14.17.0-linux-armv7l.tar" -C "${shloc}/nodejsdownload/"
            cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-armv7l/bin/" "/usr/"
            cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-armv7l/include/" "/usr/"
            cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-armv7l/lib/" "/usr/"
            cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-armv7l/share/" "/usr/"
        ;;
        *)
        #unknown
            echo -e "${BRED}这是个未知的架构${PLAIN}"
            echo -e "${BCYAN}请选择所需安装的nodejs${PLAIN}"
            echo -e "${BCYAN}  1.   x64${PLAIN}"
            echo -e "${BCYAN}  2.   ARMv8${PLAIN}"
            echo -e "${BCYAN}  3.   ARMv7${PLAIN}"
            echo -e ""
            read -p "请选择：" choose
            case $choose in
            1)
            #amd64
                echo -e "${BMAGENTA}开始安装node-v14.17.0-linux-x64${PLAIN}"
                mkdir "${shloc}/nodejsdownload/"
                wget -P "${shloc}/nodejsdownload/" "https://nodejs.org/dist/v14.17.0/node-v14.17.0-linux-x64.tar.xz"
                xz -d "${shloc}/nodejsdownload/node-v14.17.0-linux-x64.tar.xz"
                tar -xvf "${shloc}/nodejsdownload/node-v14.17.0-linux-x64.tar" -C "${shloc}/nodejsdownload/"
                cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-x64/bin/" "/usr/"
                cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-x64/include/" "/usr/"
                cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-x64/lib/" "/usr/"
                cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-x64/share/" "/usr/"
            ;;
            2)
            #ARMv8
                echo -e "${BMAGENTA}开始安装node-v14.17.0-linux-arm64${PLAIN}"
                mkdir "${shloc}/nodejsdownload/"
                wget -P "${shloc}/nodejsdownload/" "https://nodejs.org/dist/v14.17.0/node-v14.17.0-linux-arm64.tar.xz"
                xz -d "${shloc}/nodejsdownload/node-v14.17.0-linux-arm64.tar.xz"
                tar -xvf "${shloc}/nodejsdownload/node-v14.17.0-linux-arm64.tar" -C "${shloc}/nodejsdownload/"
                cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-arm64/bin/" "/usr/"
                cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-arm64/include/" "/usr/"
                cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-arm64/lib/" "/usr/"
                cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-arm64/share/" "/usr/"

            ;;
            3)
            #ARMv7
                echo -e "${BMAGENTA}开始安装node-v14.17.0-linux-armv7l${PLAIN}"
                mkdir "${shloc}/nodejsdownload/"
                wget -P "${shloc}/nodejsdownload/" "https://nodejs.org/dist/v14.17.0/node-v14.17.0-linux-armv7l.tar.xz"
                xz -d "${shloc}/nodejsdownload/node-v14.17.0-linux-armv7l.tar.xz"
                tar -xvf "${shloc}/nodejsdownload/node-v14.17.0-linux-armv7l.tar" -C "${shloc}/nodejsdownload/"
                cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-armv7l/bin/" "/usr/"
                cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-armv7l/include/" "/usr/"
                cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-armv7l/lib/" "/usr/"
                cp -r "${shloc}/nodejsdownload/node-v14.17.0-linux-armv7l/share/" "/usr/"
            ;;
            esac
        ;;
        esac
        rm -rf "${shloc}/nodejsdownload/"
        echo -e "${MAGENTA}DONE${PLAIN}"
    ;;
    5)
    #卸载通过二进制文件安装的nodejs
        echo -e "${BCYAN}正在卸载${PLAIN}"
        rm -rf "/usr/bin/node"
        rm -rf "/usr/bin/npm"
        rm -rf "/usr/bin/npx"
        rm -rf "/usr/include/node/"
        rm -rf "/usr/lib/node_modules/"
        rm -rf "/usr/share/doc/node/"
        rm -rf "/usr/share/man/man1/node.1"
        rm -rf "/usr/share/systemtap/tapset/node.stp"
        echo -e "${MAGENTA}DONE${PLAIN}"
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
#好选
    clear
    echo -e "好 非常好"
    echo -e "在${time}"
    echo -e "你在一个只有${BMAGENTA}1-16${PLAIN}的菜单中选择了${BMAGENTA}${choose}${PLAIN}"
;;
esac
