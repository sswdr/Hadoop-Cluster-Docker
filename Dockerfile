# ------------------������ʱ��������ѹhadoop��װ��----
FROM ubuntu:20.04 as build
COPY tar/hadoop-2.7.2.tar.gz /root
RUN cd /root && tar -xzvf hadoop-2.7.2.tar.gz


# ------------------��ʼ����hadoop����------------------
FROM ubuntu:20.04

MAINTAINER sswdr <sswdr@foxmail.com>

WORKDIR /root

# 20220906��ȥ��ѹ����ֱ�ӷ��ļ��м�����һ��COPY�������
# install hadoop 2.7.2
COPY --from=build /root/hadoop-2.7.2 /usr/local/hadoop

# 20220906������������
# install openssh-server, openjdk��vim��rsync��wget��ping��net-tools
RUN apt-get update && apt-get install -y openssh-server openjdk-8-jdk vim rsync wget inetutils-ping net-tools \
    && apt-get autoclean && apt-get autoremove && apt-get clean

# install xsync
COPY xsync/xsync /bin
RUN cd /bin && \
    chmod +x xsync

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 
ENV HADOOP_HOME=/usr/local/hadoop 
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin

# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

RUN mkdir -p ~/hdfs/namenode && \ 
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

COPY config/* /tmp/

RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh

RUN chmod +x ~/start-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh 

# format namenode
RUN /usr/local/hadoop/bin/hdfs namenode -format

# ���ô�½ʱ��
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

CMD [ "sh", "-c", "service ssh start; bash"]
