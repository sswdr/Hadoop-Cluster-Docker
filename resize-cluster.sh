#!/bin/bash

# N is the node number of hadoop cluster
N=$1

if [ $# = 0 ]
then
	echo "Please specify the node number of hadoop cluster!"
	exit 1
fi

# change slaves file
i=1
rm config/slaves
while [ $i -lt $N ]
do
	echo "hadoop-slave$i" >> config/slaves
	((i++))
done 

echo ""

echo -e "\nbuild docker hadoop image\n"

# rebuild sswdr/hadoop2.7.2:ubuntu20.04 image
sudo docker build -t sswdr/hadoop2.7.2:ubuntu20.04 .

echo ""
