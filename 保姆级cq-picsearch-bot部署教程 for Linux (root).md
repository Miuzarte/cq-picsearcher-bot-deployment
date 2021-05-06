# 保姆级cq-picsearcher-bot部署运行教程 for Linux (root)

__看完一遍再动手 看完一遍再动手 看完一遍再动手__

__看完一遍再动手 看完一遍再动手 看完一遍再动手__

__看完一遍再动手 看完一遍再动手 看完一遍再动手__

&nbsp;

## 部署运行

### 0. 首先你得有wget,git,screen这几个命令

1. 安装

   For Ubuntu: `apt install -y wget git screen`

   For CentOS: `yum install -y wget git screen`

### 1. 部署go-cqhttp

0. 新建窗口

   `screen -S qq`

1. 访问go-cqhttp的[[releases]](https://github.com/Mrs4s/go-cqhttp/releases)页面获取最新版本

    右键 go-cqhttp_linux_**amd64**.tar.gz 复制下载链接

    __*一般服务器架构都为amd64(x86),树莓派,安卓手机等设备下载arm64__

    `mkdir go-cqhttp && cd go-cqhttp`

    `wget [粘贴链接]`

    ~~什么 下载不了?那你怎么访问的GitHub~~

    `tar -zxvf go-cqhttp_linux_amd64.tar.gz`

    `chmod -R 700 ./go-cqhttp`

2. 运行一遍使其生成默认配置文件

    `./go-cqhttp faststart`

3. 编辑生成的`config.yml`

    根据注释填写QQ号与QQ密码,__QQ号不需要引号,QQ密码需要__,其余保持默认

    在第91行,将`#正向ws`的`disable: true`改为`disable: false`

    __*部署在公网服务器建议设置访问密钥`access_token`,尤其是开放了所有端口的服务器__

4. 再次运行go-cqhttp

    `./go-cqhttp faststart`

    此时程序会自动生成虚拟设备信息,不用理会

    根据命令行输出的提示去验证登录QQ

5. 完事退出窗口,go-cqhttp**留在后台**

    <kbd>Ctrl</kbd> + <kbd>A</kbd> + <kbd>D</kbd>

6. 安装ffmpeg使go-cqhttp可以发送其他格式的`语音`和`短视频`,机器人发送番剧预览视频会用到

   For Ubuntu: `apt install -y ffmpeg`

   For CentOS: `yum install -y ffmpeg`

### 2. 部署cq-picsearcher-bot

1. 安装nodejs

   `curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -`

2. 获取cq-picsearcher-bot项目,默认最新版本

   `git clone https://github.com/Tsuk1ko/cq-picsearcher-bot && cd cq-picsearcher-bot && cp config.default.jsonc config.jsonc`

3. 安装依赖[[参考原作者部署流程]](https://github.com/Tsuk1ko/cq-picsearcher-bot/wiki/%E9%83%A8%E7%BD%B2%E6%B5%81%E7%A8%8B#3-%E9%83%A8%E7%BD%B2%E6%9C%AC%E9%A1%B9%E7%9B%AE)

   * 服务器在海外等网络正常的情况下,直接安装

     `npm i`

   * 服务器在国内网络不正常的情况下,使用淘宝(阿里)源安装

     `npm config set registry https://registry.npm.taobao.org --global && npm config set disturl https://npm.taobao.org/dist --global && npm i`

4. 编辑`config.jsonc`

   __go-cqhttp中设置了访问密钥`access_token`的需要填入__

   __saucenao搜图需要填入api key,在[[这里]](https://saucenao.com/user.php)注册登录之后再到[[这里]](https://saucenao.com/user.php?page=search-api)复制api key__

   其他的照着注释写,不会写的就保持默认,一行一行仔细看好注释

   部分需要特别注意的在这: __[[配置文件说明]](https://github.com/Tsuk1ko/cq-picsearcher-bot/wiki/%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E8%AF%B4%E6%98%8E)__

5. 运行cq-picsearcher-bot

   `npm start`

   输出中的"status"栏如果没有显示"online"

   就`reboot`

   之后`screen -S qq`

   然后`cd go-cqhttp && ./go-cqhttp faststart`

   再<kbd>Ctrl</kbd> + <kbd>A</kbd> + <kbd>D</kbd>

   最后`cd cq-picsearcher-bot && npm start`

__到现在bot就已经正常运行了,遇到问题请查看cq-picsearcher-bot的[[wiki]](https://github.com/Tsuk1ko/cq-picsearcher-bot/wiki),本文只负责教你部署运行__

&nbsp;

## 一些部署之后的事情

### 0. 重启之后如何重新运行?

​    `screen -S qq`

​     `cd go-cqhttp && ./go-cqhttp faststart`

​     <kbd>Ctrl</kbd> + <kbd>A</kbd> + <kbd>D</kbd>

​     `cd cq-picsearcher-bot && npm start`

### 1. 更新go-cqhttp

​		`screen -r qq`

​		<kbd>Ctrl</kbd> + <kbd>C</kbd>

​		访问go-cqhttp的[[releases]](https://github.com/Mrs4s/go-cqhttp/releases)页面获取最新版本

​		右键 go-cqhttp_linux_**amd64**.tar.gz 复制下载链接

​		`wget [粘贴链接]`

​     `tar -zxvf go-cqhttp_linux_amd64.tar.gz && chmod -R 700 ./go-cqhttp && ./go-cqhttp faststart`

​     <kbd>Ctrl</kbd> + <kbd>A</kbd> + <kbd>D</kbd>

### 2. 更新cq-picsearcher-bot

​		__默认每24小时间检查一次更新,有更新会推送至管理员账号__

​		`cd cq-picsearcher-bot ; npm stop && git pull && npm i && npm start`

​		配置文件方面,不建议cp覆盖后重写

​		访问cq-picsearcher-bot的[[commits]](https://github.com/Tsuk1ko/cq-picsearcher-bot/commits/master)页面,点击最新的commit,将'config.default.jsonc'中新增(绿色高亮)的部分(如果有的话)复制粘贴去本地的'config.jsonc'

​		__*根据上下文去粘贴__

&nbsp;

## About:

### go-cqhttp: 

**[[github]](https://github.com/Mrs4s/go-cqhttp) [[wiki]](https://docs.go-cqhttp.org/guide/)**

### cq-picsearcher-bot: 

**[[github]](https://github.com/Tsuk1ko/cq-picsearcher-bot) [[wiki]](https://github.com/Tsuk1ko/cq-picsearcher-bot/wiki)**

### node.js
**[[website]](http://nodejs.cn/) [[wiki]](http://nodejs.cn/learn)**

&nbsp;

## 推荐的工具

__(我只是做个推荐,爱用什么看你)__

### ssh类:
1. __Xshell__ on Windows
2. __Windows Terminal__ on Windows
3. __Termux__ on Android

### 文件管理类:
1. __Xftp__ on Windows
2. __x-plore__ on Android

### 编辑类:
1. __Microsoft Visual Studio Code__ on Windows
2. __MT管理器2__ on Android

