#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo docker build -t sswdr/hadoop:ubuntu20.4 .

echo ""