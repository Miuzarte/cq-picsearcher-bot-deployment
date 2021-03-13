# 保姆级cq-picsearch-bot部署运行教程 for Linux (root)
__（听话,从<u>根目录</u>开始）__

__看完一遍再动手 看完一遍再动手 看完一遍再动手__

__看完一遍再动手 看完一遍再动手 看完一遍再动手__

__看完一遍再动手 看完一遍再动手 看完一遍再动手__

&nbsp;

## 部署运行

### 0. 首先你得有wget,git,screen这几个命令

1. 安装

   For Ubuntu: `apt install wget && apt install git && apt install screen`

   For CentOS: `yum install wget && yum install git && yum install screen`

### 1. 部署go-cqhttp[^不以任何版本为例]

0. 新建窗口

   `screen -S qq`

1. 访问go-cqhttp的__[[releases]](https://github.com/Mrs4s/go-cqhttp/releases)__页面获取最新版本
    右键go-cqhttp-(version)-linux-__amd64__ ~~or go-cqhttp-(version)-linux-__amd64__.tar.gz~~复制下载链接
    后者需解压,可👴懒得教tar命令怎么用
    `mkdir go-cqhttp && cd go-cqhttp && wget [粘贴链接] && mv go-cqhttp-(version)-linux-amd64 go-cqhttp && chmod -R 744 ./go-cqhttp`

    __*(version)自己改__

    __*分不清 arm/arm64 和 i386/amd64 的建议给群友发个红包然后去问__

2. 运行一遍使其生成默认配置文件
    `./go-cqhttp faststart`

3. 编辑生成的`config.hjson`
    根据注释填写QQ号与QQ密码,部署在公网服务器建议设置__访问密钥__`access_token`

    __*尤其是开放了所有端口的服务器__

4. 再次运行go-cqhttp
    `./go-cqhttp faststart`
    此时程序会自动生成虚拟设备信息,不用理会
    根据命令行输出的提示去验证登录QQ

5. 完事退出窗口,go-cqhttp__留在后台__
    <kbd>Ctrl</kbd> + <kbd>A</kbd> + <kbd>D</kbd>

### 2. 部署cq-picsearch-bot

1.  安装nodejs

   For Ubuntu: `apt install nodejs`

   For CentOS: `yum install nodejs`

   确保版本号\>=10.16.0 (大多数情况下不会低于)

2.  获取cq-picsearch-bot项目,默认最新版本

   `git clone https://github.com/Tsuk1ko/cq-picsearcher-bot && cd cq-picsearcher-bot && cp config.default.jsonc config.jsonc`

3. 安装依赖

   * 服务器在海外等网络正常的情况下,直接安装

     `npm i`

   * 服务器在国内网络不正常的情况下,使用淘宝(阿里)源安装

     `npm config set registry https://registry.npm.taobao.org --global && npm config set disturl https://npm.taobao.org/dist --global && npm i`

4. 编辑`config.jsonc`

   __go-cqhttp中设置了访问密钥`access_token`的需要在第八行填入__

   __saucenao搜图需要填入api key,在[[这里]](https://saucenao.com/user.php)注册登录之后再到[[这里]](https://saucenao.com/user.php?page=search-api)复制api key__

   其他的照着注释写,不会写的就保持默认,给👴一行一行仔细看好注释

   部分需要特别注意的在这: __[[配置文件说明]](https://github.com/Tsuk1ko/cq-picsearcher-bot/wiki/%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E8%AF%B4%E6%98%8E)__

5. 运行cq-picsearch-bot

   `npm start`

   输出中的"status"栏如果没有显示"online"

   就`reboot`

   之后`screen -S qq`

   然后`cd go-cqhttp && ./go-cqhttp faststart`

   再<kbd>Ctrl</kbd> + <kbd>A</kbd> + <kbd>D</kbd>

   最后`cd cq-picsearch-bot && npm start`

__到现在bot就已经正常运行了,遇到问题请查看cq-picsearcher-bot的[[wiki]](https://github.com/Tsuk1ko/cq-picsearcher-bot/wiki),本文只负责教你部署运行__

&nbsp;

## 一些部署之后的事情[^保姆级,全写一条里了]

### 0. 重启之后如何重新运行?

​		建议往上看看,找找`reboot`

### 1. 更新go-cqhttp

​		`screen -r qq`

​		<kbd>Ctrl</kbd> + <kbd>C</kbd>

​		访问go-cqhttp的__[[releases]](https://github.com/Mrs4s/go-cqhttp/releases)__页面获取最新版本

​		右键go-cqhttp-(version)-linux-__amd64__复制下载链接

​		`rm -rf ./go-cqhttp && wget [粘贴链接] && mv go-cqhttp-(version)-linux-amd64 go-cqhttp && chmod -R 744 ./go-cqhttp && ./go-cqhttp faststart`

​		<kbd>Ctrl</kbd> + <kbd>A</kbd> + <kbd>D</kbd>

### 2. 更新cq-picsearch-bot

​		__默认每24小时间检查一次更新,有更新会推送至管理员账号__

​		`cd cq-picsearch-bot ; npm stop && git fetch --all && git reset --hard origin/master && git pull && npm start`

&nbsp;

## About:

### go-cqhttp: 

__[[github]](https://github.com/Mrs4s/go-cqhttp) [[wiki]](https://docs.go-cqhttp.org/guide/)__

### cq-picsearch-bot: 

__[[github]](https://github.com/Tsuk1ko/cq-picsearcher-bot) [[wiki]](https://github.com/Tsuk1ko/cq-picsearcher-bot/wiki)__

&nbsp;

## 推荐的工具

__(我只是做个推荐,爱用什么看你)__

### ssh类:
1. __Finalshell__ on Windows
2. __JuiceSSH__ on Android

### 文件管理类:

1. __Finalshell__ on Windows [^支持自动上传编辑后的文件]
2. __x-plore__ on Android [^支持直接编辑文件]

### 编辑类:
1. __Microsoft Visual Studio Code__ on Windows [^这玩意还要吹?]
2. __MT管理器2__ on Android [^够用]

&nbsp;

__(什么,你用iOS的?私密马赛,是我不配推荐)__

&nbsp;

[^不以任何版本为例]: 所以说你要自己粘贴链接
[^保姆级,全写一条里了]: 什么?出问题了?那你拆开输试试咯
[^支持自动上传编辑后的文件]: 在vsc中编辑完毕后保存,会自动上传更新后的文件至服务器
[^支持直接编辑文件]: 不能有其他应用关联了要编辑文件的格式,否则可能仍需要下载到本地编辑后再手动上传
[^这玩意还要吹?]: 谁用notepad++谁死妈
[^够用]: 真的只是够用

