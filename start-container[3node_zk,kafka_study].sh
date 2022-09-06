#!/bin/bash

echo "start hadoop-master container..."
sudo docker run -itd \
                --net=hadoop \
                -p 50070:50070 \
                -p 8088:8088 \
                -p 2181:2181 \
                -p 9092:9092 \
                --name hadoop-master \
                --hostname hadoop-master \
                sswdr/hadoop2.7.2:ubuntu20.04 &> /dev/null

echo "start hadoop-slave1 container..."
sudo docker run -itd \
                --net=hadoop \
                -p 2182:2181 \
                -p 9093:9092 \
                --name hadoop-slave1 \
                --hostname hadoop-slave1 \
                sswdr/hadoop2.7.2:ubuntu20.04 &> /dev/null

echo "start hadoop-slave2 container..."
sudo docker run -itd \
                --net=hadoop \
                -p 2183:2181 \
                -p 9094:9092 \
                --name hadoop-slave2 \
                --hostname hadoop-slave2 \
                sswdr/hadoop2.7.2:ubuntu20.04 &> /dev/null
