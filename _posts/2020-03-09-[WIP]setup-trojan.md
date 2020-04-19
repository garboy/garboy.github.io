---
title:  "CentOS 8 安装Trojan"
date:   2020-03-09 10:01:18 +0800
categories: vps
---

## Trojan GFW

### 准备工具

VPS主机一台，需要有root 密码。
域名一个(GoDaddy申请)，
SSL证书一份(Lets Encrypt)
DNS A记录(域名->VPS IP)

### Quick Install Trojan

`sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/trojan-gfw/trojan-quickstart/master/trojan-quickstart.sh)"`

```bash

Entering temp directory /tmp/tmp.K8NLUVwgsN...
Downloading trojan 1.14.1...
################################################################################################ 100.0%################################################################################################ 100.0%
Unpacking trojan 1.14.1...
Installing trojan 1.14.1 to /usr/local/bin/trojan...
Installing trojan server config to /usr/local/etc/trojan/config.json...
Installing trojan systemd service to /etc/systemd/system/trojan.service...
Reloading systemd daemon...
Deleting temp directory /tmp/tmp.K8NLUVwgsN...
Done!

```

### Install Apache

```bash
sudo yum install httpd
sudo systemctl enable httpd
sudo systemctl start httpd
```

apache wwwroot 目录位于`/var/www/html`

### Enbale Firewall

```bash
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload
```

可以用`sudo firewall-cmd --list-all` 检查一下是否开启了http, https 这两个服务。否则下一步安装SSL证书会失败。
这时，访问一下VPS的IP或者域名，如果能够打开http页面，说明服务和防火墙都成功设置。

### Install SSL Cert

使用Certbot来安装Lets Encrypt的SSL证书

```bash
wget https://dl.eff.org/certbot-auto
sudo mv certbot-auto /usr/local/bin/certbot-auto
sudo chown root /usr/local/bin/certbot-auto
sudo chmod 0755 /usr/local/bin/certbot-auto
```

`./certbot-auto certonly --standalone`

成功安装后，屏幕应该能看到如下信息

```bash
[root@vultrguest bin]# systemctl stop httpd
[root@vultrguest bin]# ./certbot-auto certonly --standalone
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator standalone, Installer None
Please enter in your domain name(s) (comma and/or space separated)  (Enter 'c'
to cancel): tr.chengwhynot.me
Obtaining a new certificate
Performing the following challenges:
http-01 challenge for tr.chengwhynot.me
Waiting for verification...
Cleaning up challenges

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/tr.chengwhynot.me/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/tr.chengwhynot.me/privkey.pem
   Your cert will expire on 2020-06-06. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot-auto
   again. To non-interactively renew *all* of your certificates, run
   "certbot-auto renew"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le
```

`/etc/letsencrypt/live/tr.chengwhynot.me/fullchain.pem`
`/etc/letsencrypt/live/tr.chengwhynot.me/privkey.pem`
记住这个证书和密钥的位置，用于替换service.json配置文件。

设置定时任务，定期更新证书。因为我们同时还启用了apache，用于启动一个静态网站，接收伪装的http请求。所以要用--pre-hook和post-hook用于刷新证书时，停止和重启httpd服务。
`echo "0 0,12 * * * root python3 -c 'import random; import time; time.sleep(random.random() * 3600)' && /usr/local/bin/certbot-auto renew -q --pre-hook 'systemctl stop httpd' --post-hook 'systemctl start httpd'" | sudo tee -a /etc/crontab > /dev/null`

### Visit your domain

前期准备完成后，尝试访问一下域名，如果能够打开一个页面，并且显示是用刚申请的SSL证书加密的，就可以。

### Start Trojan

`nohup ./trojan -c /usr/local/etc/trojan/config.json > server.log 2>&1 &` 之后运行`netstat -lnpt`  
应该能看到80和443端口都被监听中。  

```bash
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      1497/sshd
tcp        0      0 0.0.0.0:443             0.0.0.0:*               LISTEN      30617/./trojan
tcp6       0      0 :::80                   :::*                    LISTEN      30758/httpd
tcp6       0      0 :::22                   :::*                    LISTEN      1497/sshd
```
