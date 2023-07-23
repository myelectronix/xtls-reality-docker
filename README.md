

# XTLS-reality-docker

This is a simple docker image which starts up in just a few seconds and launch a proxy-server ready to accept client connections. This proxy-server does not encrypt your data, but it can masquerade your traffic as a regular TLS-connection. To unauthorized users your proxy-server will look like a harmless site.


To get it running, just copy & paste the snippet below in your terminal:

```bash
sudo docker run -d --rm -p 443:443 -v xtls-reality-volume:/opt/xray/config --name xtls-reality myelectronix/xtls-reality
```

The XTLS-Reality proxy server will be up and ready to accept connections on port 443.

To get more detailed information, go to [Quick Start](#-quick-start).



## Sources

| Name | URL 
| :--: | :-----: |
| GitHub | <https://github.com/myelectronix/xtls-reality-docker> |
| Docker Hub | <https://hub.docker.com/repository/docker/myelectronix/xtls-reality/general> |
| XTLS GitHub  | <https://github.com/XTLS> |
| Habr  | <https://habr.com/ru/articles/731608/> |


## Container properties


### Environment variables

| Variable | Description | Default value |
| :------: | :---------: | :-----------: |
| SNI | A website address for masquerade. It must support TLSv1.3 and HTTP/2  | www.samsung.com |
| SHORT_ID | Short ID. You can generate any 32-bit number in HEX-format | aabbccdd |



### Container commands

After container was run using `docker run` or `docker compose up` command, it's possible to execute additional commands using `docker exec` command. For example, `sudo docker exec xtls-reality bash get-client-qr.sh`. See table below to get the full list of supported commands.

| Command  | Description | 
| :------: | :---------: | 
| `get-client-qr.sh` | Outputs a QR-code with client settings. You can scan this code by a mobile application (for exampe, v2rayNG) and get a quick connection. |  |
| `get-client-settings.sh` | Outputs a client settings in text form | 
| `regenerate-client-settings.sh` | Generate a new UUID, Private and Public key. Docker container must be reload | 



## Quick Start

### 1. Prerequisites

1. Any hardware or vps/vds server running Linux. You must have administrative rights on this machine.
2. Docker installation on your server.For more information please see https://docs.docker.com/engine/install/ 
3. Your server must have a public IP-address
   
### 2. XTLS-reality proxy server run
You can run XTLS-reality proxy server in two ways of your choice: docker run or docker compose.

#### 2.1. Docker run
Pull the latest version of XTLS-reality-docker image:
```bash
sudo docker pull myelectronix/xtls-reality:latest
```

Copy & paste the following command to run XTLS-reality-docker:<br>

```bash
sudo docker run -d --rm  \
-p 443:443 \
-e SNI=YOUR_SNI \
-e SHORT_ID=YOUR_SHORT_ID \
-v xtls-reality-volume:/opt/xray/config \
--name xtls-reality myelectronix/xtls-reality:latest
```

**⚠️ Note:** You must specify the desired values instead ***YOUR_SNI*** and  ***YOUR_SHORT_ID***. You can skip these lines in the command, in this case the default values will be used.

To check a status of the container you can execute the following command
```bash
sudo docker ps
 ```
The output should look like this
```bash
CONTAINER ID   IMAGE                       COMMAND                  CREATED         STATUS                                        PORTS                                   NAMES
82d35a13b672   myelectronix/xtls-reality   "/bin/bash ./entrypo…"   8 seconds ago   Up 7 seconds                                  0.0.0.0:443->443/tcp, :::443->443/tcp   xtls-reality
 ```

#### 2.2. Docker compose
The another way of start up XTLS-reality proxy-server is docker compose. Docker compose saves all startup options in a special file and can automatically restart containers if they fail. Firts of all you must install docker compose plugin. For more information please see https://docs.docker.com/compose/install/linux/

After install docker compose plugin clone this git repository:

```bash
git clone https://github.com/myelectronix/xtls-reality-docker
```


Change your work directory and run docker compose
```bash
cd xtls-reality-docker
sudo docker compose up -d
```

**⚠️ Note:** You can specify the desired values ***SNI*** and  ***SHORT_ID*** in `docker-compose.yaml` file before launch docker compose or leave a default values.

To check a status of the container you can execute the following command
```bash
sudo docker ps
 ```
The output should look like this
```bash
CONTAINER ID   IMAGE                       COMMAND                  CREATED         STATUS                                        PORTS                                   NAMES
82d35a13b672   myelectronix/xtls-reality   "/bin/bash ./entrypo…"   8 seconds ago   Up 7 seconds                                  0.0.0.0:443->443/tcp, :::443->443/tcp   xtls-reality
 ```

 
### 3. Get client configuration
After run  XTLS-reality docker you can get a settings for client connection. You have a two ways for get connection: QR-code or text form. To get the QR code, run the following command
```bash
sudo docker exec xtls-reality bash get-client-qr.sh
 ```
The result will be a generated QR-code in your terminal as shown below

<p align=center> <img src=images/QR.png width="198" heightalign=center></p>

To get the text form settings, run the following command
```bash
sudo docker exec xtls-reality bash get-client-settings.sh
 ```
The result will be a text settings in your terminal as shown below
```bash
IP Address: XXX.XXX.XXX.XXX
UUID: e4a047bb-fd0a-4742-b52d-4ef83fae4ef2
Public key: gF5RvoxnC5btsqZ9YvNLtH-gaUfcrDXDLif-NM7oFQ4
SNI: www.samsung.com
ShortID: aabbccdd
 ```

### 4. Connecting Clients

You can use various proxy client programs to connect to your XTLS reality proxy. 

If you use **windows** you can use [NekoBox](https://github.com/MatsuriDayo/nekoray/releases)

In **NekoBox** window select  *Preferences - Basic Settings - Core* and set *sing-box* button

<p align=center> <img src=images/NekoBoxCore.png width="1900" heightalign=center></p>

Then select *Server - New Profile  - VLESS* and set the settings according to the picture below, use your IP-address, UUID, SNI, Public key and ShortID.

<p align=center> <img src=images/NekoBoxVLESSSettings.png width="1900" heightalign=center></p>

Then save the settings and launch your proxy. For testing the connection use *Current Select - URL Test*

If you use **android** you can install [v2rayNG](https://play.google.com/store/apps/details?id=com.v2ray.ang&hl=en_US)

To connection v2rayNG select *Import config from QRcode* and scan QR-code with your settings.
<p align=center> <img src=images/v2rayNGConfig.png width="300" heightalign=center></p>

As a result you should have a new connection in the list.

<p align=center> <img src=images/v2rayNGNewConnection.png width="300" heightalign=center></p>

Activate it and use your XTLS-reality proxy.


## Stop and remove
To stop and remove your XTLS-reality-docker container execute the following command
```bash
sudo docker rm --force xtls-reality 
 ```
Your settings (UUID, Private and Public keys) storaged in special docker volume. So they won't change when you delete a container and start a new one. If you desire remove all your settings execute the following command after stop and remove docker container.
```bash
sudo docker volume rm xtls-reality 
 ```

