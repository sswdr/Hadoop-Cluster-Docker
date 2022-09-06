#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo docker build -t sswdr/hadoop2.7.2:ubuntu20.04 .

echo ""