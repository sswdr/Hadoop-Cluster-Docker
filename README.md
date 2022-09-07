## Run Hadoop Cluster within Docker Containers
### 基于kiwenlau/hadoop:1.0，用于Hadoop学习（xsync）
##### 1. Jdk升级为1.8
##### 2. Ubuntu更新为20.4
##### 3. 安装openssh-server openjdk-8-jdk vim rsync wget inetutils-ping net-tools
##### 4. 安装自定义rsync的xsync，xcall批量输出jps命令输出结果查看状态

### 2022.09.06更新
##### 1.镜像修改为默认只启动3个[start-container.sh]（1master+2slave）
##### 2.设置中国时区[ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime]
##### 3.清理缓存[apt-get autoclean && apt-get autoremove && apt-get clean]
##### 4.镜像去除COPY压缩包的一层
##### 5.修改标签 sswdr/hadoop2.7.2:ubuntu20.04

## 感谢
- https://github.com/kiwenlau/hadoop-cluster-docker