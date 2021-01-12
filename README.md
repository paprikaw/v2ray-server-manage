# V2RAY 部署脚本
> 这一系列脚本是我用于快速部署v2ray的工具
> 本脚本目前只支持debian 9+ 的vps服务端
## Workflow
* 部署之前

    在开始使用脚本之前，需指定三个environment viriables，分别是：
  * REMOTE_SSH: 服务器DNS，格式为: username@address
  * V2RAY_CLIENT_CONFIG_LOC: 本地v2ray客户端的文件位置
  * V2RAY_SERVER_CONFIG_LOC: 本地v2ray服务器端的文件位置
* 快速部署
  * 执行 
    ```bash
    $ sudo ./v2ray-deployment.sh -d domain 
    ```
    这里的domain是用于vls安全验证的域名
  * 执行
    ```bash
    $ ./sync-config.sh -cs 
    ``` 
    这将把本地的config文件同步至本地v2ray客户端和vps的v2ray服务端并分别重启v2ray

* 增加一台新的服务器
  * 增加新的DNS记录导向目标服务器的IP地址，我们假设新的地址为domain.com
  * 执行 
    ```bash
    $ ./switch-vps.sh -a username@hostname -i new_ip_address -d new_domain
    ```
  * 执行
    ```bash
    $ sudo ./v2ray-deployment.sh -d domain.com
    ```
    这个命令将部署v2ray至新服务器
  * 执行
    ```bash
    $ ./sync-config.sh -cs 
    ```

* 快速切换服务器

    假设现在我们有两台配置好的服务器

  * 执行 
    ```bash
    $ ./switch-vps.sh -a username@hostname -i new_ip_address
    ```
  * 执行
    ```bash
    $ ./sync-config.sh -cs 
    ```