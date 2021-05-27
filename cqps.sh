#!/bin/bash
#cq-picsearcher-bot 不算懒人脚本 by Miuzarte
#https://github.com/Tsuk1ko/cq-picsearcher-bot
#https://github.com/Miuzarte/

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
shloc=$(cd `dirname $0`; pwd)   #脚本所在绝对路径 ${shloc}

#clear
#echo -e "${BRED}------------------------------------------------${PLAIN}"
#echo -e "cq-picsearcher-bot 不算懒人脚本"
#echo -e "更新时间 2021/05/22-Sat"
#echo -e "这个垃圾脚本需要的注意事项:"
#echo -e "大部分操作还是需要阅读我之前写的部署教程"
#echo -e "https://github.com/Miuzarte/cq-picsearcher-bot-deployment"
#echo -e "go-cqhttp/文件夹会生成在脚本的当前目录"
#echo -e "cq-picsearcher-bot/文件夹会生成在脚本的当前目录"
#echo -e "自启动如果写入crontab -e失败也不会报错"
#echo -e "自启动用的全是crontab -e @reboot"
#echo -e "执行部署CQPSor更新CQPS之后设定的git镜像站不会恢复"
#echo -e "${BRED}------------------------------------------------${PLAIN}"
#echo -e "${BCYAN}回车继续${PLAIN}"
#read -p ""
clear
echo -e "------------------------------------------------"
echo -e "cq-picsearcher-bot 懒人脚本"
echo -e "更新时间 2021/05/27-Thu"
echo -e "这个垃圾脚本需要的注意事项:"
echo -e "大部分操作还是需要阅读我之前写的部署教程"
echo -e "https://github.com/Miuzarte/cq-picsearcher-bot-deployment"
echo -e "go-cqhttp/和cq-picsearcher-bot/文件夹会生成在脚本的当前目录"
echo -e "自启动用的全是crontab -e @reboot"
echo -e "自启动如果写入crontab -e失败也不会报错"
echo -e "执行部署CQPSor更新CQPS之后设定的git镜像站不会恢复"
echo -e "------------------------------------------------"
echo -e "  ${BCYAN}1.   ${BGREEN}启动${PLAIN}go-cqhttp${PLAIN}"
echo -e "  ${BCYAN}2.   ${BGREEN}启动${PLAIN}CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "  ${BCYAN}3.   ${BRED}关闭${PLAIN}go-cqhttp${PLAIN}"
echo -e "  ${BCYAN}4.   ${BRED}关闭${PLAIN}CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "  ${BCYAN}5.   ${BYELLOW}查看${PLAIN}go-cqhttp${BYELLOW}日志${PLAIN}"
echo -e "  ${BCYAN}6.   ${BYELLOW}查看${PLAIN}CQPS${BYELLOW}     日志${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "  ${BCYAN}7.   ${BBLUE}设置${PLAIN}go-cqhttp crontab@reboot${BBLUE}自启${PLAIN}"
echo -e "  ${BCYAN}8.   ${BBLUE}设置${PLAIN}CQPS      crontab@reboot${BBLUE}自启${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "  ${BCYAN}9.   ${BMAGENTA}更新${PLAIN}go-cqhttp${PLAIN}"
echo -e "  ${BCYAN}10.  ${BMAGENTA}更新${PLAIN}CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "  ${BCYAN}11.  ${BMAGENTA}部署${PLAIN}go-cqhttp${PLAIN}"
echo -e "  ${BCYAN}12.  ${BMAGENTA}部署${PLAIN}CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "  ${BCYAN}13.  ${RED}删除${PLAIN}go-cqhttp${PLAIN}"
echo -e "  ${BCYAN}14.  ${RED}删除${PLAIN}CQPS${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e "  ${BCYAN}15.  ${PLAIN}其他选项${PLAIN}"
echo -e "  ${BCYAN}16.  ${PLAIN}显示项目信息${PLAIN}"
echo -e "${BBLACK}------------------------------------------------${PLAIN}"
echo -e ""
read -p "请选择：" choose
time=$(date "+%Y年%m月%d日的%H时%M分%S秒")
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
            echo -e "已创建名为"gocq"的screen并启动go-cqhttp"
        else
            echo -e "go-cqhttp正在运行中"
        fi

    ;;
    2)
    #启动CQPS
        clear
        cd "${shloc}/cq-picsearcher-bot/"
        npm start

    ;;
    3)
    #关闭go-cqhttp
        #判断go-cqhttp进程是否存在
        gcst=`ps -ef |grep -w go-cqhttp|grep -v grep|wc -l`
        if
            [ $gcst = 0 ]
        then
            echo -e "go-cqhttp没有在运行"
        else
            pkill -P go-cqhttp
            screen -S gocq -X quit
        fi

    ;;
    4)
    #关闭CQPS
        clear
        cd "${shloc}/cq-picsearcher-bot/"
        npm stop

    ;;
    5)
    #查看go-cqhttp日志
        #判断go-cqhttp进程是否存在
        gcst=`ps -ef |grep -w go-cqhttp|grep -v grep|wc -l`
        if
            [ $gcst = 0 ]
        then
            echo -e "go-cqhttp没有在运行"
        else
            echo -e "${BCYAN}进入之后 'Ctrl + A + D' 退出"
            echo -e "回车继续"
            read -p ""
            screen -r gocq
        fi

    ;;
    6)
    #查看CQPS日志
        cd "${shloc}/cq-picsearcher-bot/"
        echo -e "${BCYAN}进入之后 'Ctrl + C' 退出"
        echo -e "回车继续"
        read -p ""
        npm run log

    ;;
    7)
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
            echo ""
            echo -e "已向 crontab -e 写入 @reboot ${shloc}/go-cqhttp/boottask/gocq.sh"
            echo -e "在第二次设置自启前请确认已将crontab -e内的${MAGENTA}@reboot ${YELLOW}${shloc}/go-cqhttp/boottask/gocq.sh${PLAIN}删除"
            echo ""
        else
            echo -e "${BRED}未部署go-cqhttp"
        fi

    ;;
    8)
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
            echo ""
            echo -e "已向 crontab -e 写入 @reboot ${shloc}/cq-picsearcher-bot/boottask/cqps.sh"
            echo -e "在第二次设置自启前请确认已将crontab -e内的${MAGENTA}@reboot ${YELLOW}${shloc}/cq-picsearcher-bot/boottask/cqps.sh${PLAIN}删除"
            echo ""
        else
            echo -e "${BRED}未部署cq-picsearcher-bot"
        fi

    ;;
    9)
    #更新go-cqhttp
        echo -e "${BCYAN}每个cqps.sh release都将只会指定一个go-cqhttp版本${PLAIN}"
        echo -e "${BCYAN}1.0.0 beta用了config.yml还一堆bug${PLAIN}"

    ;;
    10)
    #更新CQPS
        cd "${shloc}/cq-picsearcher-bot/"
        npm stop
        git config --global https.https://github.com.proxy url."https://github.com.cnpmjs.org/".insteadOf https://github.com/
        git fetch --all
        git reset --hard origin/master
        git pull
        npm start

    ;;
    11)
    #部署go-cqhttp
        #判断是否二次部署
        checkfile=${shloc}/go-cqhttp/
        if
            test -d "$checkfile"
        then
            mv "${shloc}/go-cqhttp/" "${shloc}/go-cqhttp.old/"
            wget -P "${shloc}/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v0.9.40-fix5/go-cqhttp_linux_amd64.tar.gz"
            mkdir "${shloc}/go-cqhttp/"
            tar -zxvf "${shloc}/go-cqhttp_linux_amd64.tar.gz" -C "${shloc}/go-cqhttp/"
            rm -rf "${shloc}/go-cqhttp_linux_amd64.tar.gz"
            chmod 700 "${shloc}/go-cqhttp/go-cqhttp"
            cd "${shloc}/go-cqhttp/"
            ./go-cqhttp faststart
            echo -e "检测到存在${shloc}/go-cqhttp/文件夹,已备份为${shloc}/go-cqhttp.old/"
            echo -e "项目拉取完毕,是否开始填写config.hjson基础配置项"
            echo -e "${BGREEN}// 输入项无需引号${PLAIN}"
            echo -e "  ${BCYAN}1.   Yes${PLAIN}"
            echo -e "  ${BCYAN}2.   No${PLAIN}"
            read -p "请选择：" choose
            case $choose in
                1)
                #Yes
                    echo -e "你选择了Yes"
                    echo -e ""

                    #"uin"
                    echo -e "QQ号"
                    read -p "uin: " input
                    sed -i 's|uin: .*,|uin: '"${input}"',|' "${shloc}/go-cqhttp/config.hjson"
                    echo -e ""

                    #"password"
                    echo -e "QQ密码"
                    read -p "password: " input
                    sed -i 's|password: ".*",|password: "'"${input}"'",|' "${shloc}/go-cqhttp/config.hjson"
                    echo -e ""

                    #"access_token"
                    echo -e "访问密钥, 强烈推荐在公网的服务器设置，可留空"
                    read -p "access_token: " input
                    sed -i 's|access_token: ".*",|access_token: "'"${input}"'",|' "${shloc}/go-cqhttp/config.hjson"
                    echo -e ""

                    echo -e "${BCYAN}DONE${PLAIN}"

                ;;
                *)
                #No
                    echo -e "你选择了No"

                    echo -e "${BCYAN}DONE${PLAIN}"

                ;;
            esac
        else
            wget -P "${shloc}/" "https://github.com.cnpmjs.org/Mrs4s/go-cqhttp/releases/download/v0.9.40-fix5/go-cqhttp_linux_amd64.tar.gz"
            mkdir "${shloc}/go-cqhttp/"
            tar -zxvf "${shloc}/go-cqhttp_linux_amd64.tar.gz" -C "${shloc}/go-cqhttp/"
            rm -rf "${shloc}/go-cqhttp_linux_amd64.tar.gz"
            chmod 700 "${shloc}/go-cqhttp/go-cqhttp"
            cd "${shloc}/go-cqhttp/"
            ./go-cqhttp faststart
            echo -e "项目拉取完毕,是否开始填写config.hjson基础配置项"
            echo -e "${BGREEN}// 输入项无需引号${PLAIN}"
            echo -e "  ${BCYAN}1.   Yes${PLAIN}"
            echo -e "  ${BCYAN}2.   No${PLAIN}"
            read -p "请选择：" choose
            case $choose in
                1)
                #Yes
                    echo -e "你选择了Yes"
                    echo -e ""

                    #"uin"
                    echo -e "QQ号"
                    read -p "uin: " input
                    sed -i 's|uin: .*,|uin: '"${input}"',|' "${shloc}/go-cqhttp/config.hjson"
                    echo -e ""

                    #"password"
                    echo -e "QQ密码"
                    read -p "password: " input
                    sed -i 's|password: ".*",|password: "'"${input}"'",|' "${shloc}/go-cqhttp/config.hjson"
                    echo -e ""

                    #"access_token"
                    echo -e "访问密钥, 强烈推荐在公网的服务器设置，可留空"
                    read -p "access_token: " input
                    sed -i 's|access_token: ".*",|access_token: "'"${input}"'",|' "${shloc}/go-cqhttp/config.hjson"
                    echo -e ""

                    echo -e "${BCYAN}DONE${PLAIN}"

                ;;
                *)
                #No
                    echo -e "你选择了No"

                    echo -e "${BCYAN}DONE${PLAIN}"

                ;;
            esac
        fi

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
            curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
            apt install -y nodejs
        elif
            test -f "$centfile"
        then
            yum install -y git screen
            curl -fsSL https://rpm.nodesource.com/setup_14.x | bash -
            yum install -y nodejs
        else
            echo -e "${BRED}警告: Linux发行版判断失败"
            echo -e "${BRED}将不会安装git,screen,nodejs"
            echo -e "脚本已暂停"
            echo -e "' Ctrl + C' 可取消部署"
            echo -e "回车则继续部署"
            read -p ""
            echo -e "请再次确认系统已安装nodejs"
            echo -e "回车继续"
            read -p ""
        fi

        #判断是否二次部署
        checkfile=${shloc}/cq-picsearcher-bot/
        if
            test -d "$checkfile"
        then
            mv "${shloc}/cq-picsearcher-bot/" "${shloc}/cq-picsearcher-bot.old/"
            git clone "https://github.com.cnpmjs.org/Tsuk1ko/cq-picsearcher-bot"
            cp "${shloc}/cq-picsearcher-bot/config.default.jsonc" "${shloc}/cq-picsearcher-bot/config.jsonc"
            cd "${shloc}/cq-picsearcher-bot/"
            echo -e "检测到存在${shloc}/cq-picsearcher-bot/文件夹,已备份为${shloc}/cq-picsearcher-bot.old/"
        else
            git clone "https://github.com.cnpmjs.org/Tsuk1ko/cq-picsearcher-bot"
            cp "${shloc}/cq-picsearcher-bot/config.default.jsonc" "${shloc}/cq-picsearcher-bot/config.jsonc"
            cd "${shloc}/cq-picsearcher-bot/"
        fi

        echo -e
        echo -e "选择yarn源"
        echo -e "  ${BCYAN}1.   官方源(海外)${PLAIN}"
        echo -e "  ${BCYAN}2.   阿里镜像源(大陆)${PLAIN}"
        echo -e
        read -p "请选择：" choose
        case $choose in
            1)
            #官方源(海外)
                npm i --force -g yarn
                yarn
            ;;
            2)
            #阿里镜像源(大陆)
                npm i --force -g yarn --registry=https://registry.npm.taobao.org
                yarn config set registry https://registry.npm.taobao.org --global
                yarn config set disturl https://npm.taobao.org/dist --global
                yarn
            ;;
            *)
            #默认阿里
                echo -e "默认选择阿里镜像源"
                npm i --force -g yarn --registry=https://registry.npm.taobao.org
                yarn config set registry https://registry.npm.taobao.org --global
                yarn config set disturl https://npm.taobao.org/dist --global
                yarn
        esac

        echo -e ""
        echo -e ""
        echo -e "项目拉取完毕,是否开始填写config.jsonc基础配置项"
        echo -e "${BGREEN}// 输入项无需引号${PLAIN}"
        echo -e "  ${BCYAN}1.   Yes${PLAIN}"
        echo -e "  ${BCYAN}2.   No${PLAIN}"
        read -p "请选择：" choose
        case $choose in
            1)
            #Yes
                echo -e "你选择了Yes"
                echo -e ""

                #"autoUpdateConfig"
                echo -e "是否启用自动更新config.jsonc"
                echo -e "  ${BCYAN}1.   true${PLAIN}(建议)"
                echo -e "  ${BCYAN}2.   false${PLAIN}(默认)"
                echo -e ""
                read -p "请选择：" choose
                case $choose in
                    1)
                    #true
                        sed -i 's|"autoUpdateConfig": false,|"autoUpdateConfig": true,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
                        echo -e "你选择了true"
                    ;;
                    *)
                    #false
                        echo -e "你选择了false"
                    ;;
                esac

                #"port"
                echo -e "go-cqhttp ws接口端口，留空则保持默认6700"
                read -p "\"port\": " input
                if
                    [ "$input" = "" ]
                then
                    echo -e "保持默认(6700)"
                    echo -e ""
                else
                    sed -i 's|"port": .*,|"port": '"${input}"',|' "${shloc}/cq-picsearcher-bot/config.jsonc"
                    echo -e ""
                fi

                #"accessToken"
                echo -e "go-cqhttp 访问密钥，无则留空"
                read -p "\"accessToken\": " input
                sed -i 's|"accessToken": ".*",|"accessToken": "'"${input}"'",|' "${shloc}/cq-picsearcher-bot/config.jsonc"
                echo -e ""

                #"admin"
                echo -e "管理者QQ，必填"
                read -p "\"admin\": " input
                sed -i 's|"admin": .*,|"admin": '"${input}"',|' "${shloc}/cq-picsearcher-bot/config.jsonc"
                echo -e ""

                #"proxy"
                echo -e "大部分请求所使用的代理，留空则不使用代理"
                echo -e "支持 http(s):// 和 socks:// \"[IP]:[Port]\""
                read -p "\"proxy\": " input
                if
                    [ "input" = "" ]
                then
                    echo -e "保持默认(不使用代理)"
                    echo -e ""
                else
                    sed -i 's|"proxy": ".*",|"proxy": "'"${input}"'",|' "${shloc}/cq-picsearcher-bot/config.jsonc"
                    echo -e ""
                fi

                #"saucenaoApiKey"
                echo -e "saucenao APIKEY，必填，否则无法使用 saucenao 搜图，留空则跳过"
                echo -e "前往"
                echo -e "${BCYAN}https://saucenao.com/user.php${PLAIN}"
                echo -e "注册登录之后"
                echo -e "再到"
                echo -e "${BCYAN}https://saucenao.com/user.php?page=search-api${PLAIN}"
                echo -e "复制api key"
                read -p "\"saucenaoApiKey\": " input
                sed -i 's|"saucenaoApiKey": ".*",|"saucenaoApiKey": "'"${input}"'",|' "${shloc}/cq-picsearcher-bot/config.jsonc"

                echo -e "${BCYAN}DONE${PLAIN}"

            ;;
            *)
            #No
                echo -e "你选择了No"
                echo -e "是否启用自动更新config.jsonc"
                echo -e "  ${BCYAN}1.   true${PLAIN}(建议)"
                echo -e "  ${BCYAN}2.   false${PLAIN}(默认)"
                echo -e ""
                read -p "请选择：" choose
                case $choose in
                    1)
                    #true
                        sed -i 's|"autoUpdateConfig": false,|"autoUpdateConfig": true,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
                        echo -e "你选择了true"
                    
                    ;;
                    *)
                    #false
                        echo -e "你选择了false"
                    
                    ;;
                esac

                echo -e "${BCYAN}DONE${PLAIN}"

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
            echo -e "go-cqhttp没有在运行"
        else
            checkfile=${shloc}/go-cqhttp/
            if
                test -d "$checkfile"
            then
                rm -rf "${shloc}/go-cqhttp/"
            else
                echo -e "${BRED}未部署go-cqhttp"
            fi
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
        echo -e "  ${BCYAN}1.   (也许能)修复CQPS无法启动"
        echo -e "${BBLACK}------------------------------------------------${PLAIN}"
        echo -e "  ${BCYAN}2.   启用自动更新config.jsonc"
        echo -e "  ${BCYAN}3.   停用自动更新config.jsonc"
        echo -e "${BBLACK}------------------------------------------------${PLAIN}"
        echo -e ""
        read -p "请选择：" choose
        case $choose in
            1)
            #(也许能)修复CQPS无法启动
                cd "${shloc}/cq-picsearcher-bot/"
                npx pm2 kill
                echo -e ""
                echo -e "${BCYAN}DONE${PLAIN}"
            ;;
            2)
            #启用自动更新config.jsonc
                sed -i 's|"autoUpdateConfig": false,|"autoUpdateConfig": true,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
               echo -e "${BCYAN}DONE${PLAIN}"
            ;;
            3)
            #停用自动更新config.jsonc
                sed -i 's|"autoUpdateConfig": true,|"autoUpdateConfig": false,|' "${shloc}/cq-picsearcher-bot/config.jsonc"
               echo -e "${BCYAN}DONE${PLAIN}"
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
