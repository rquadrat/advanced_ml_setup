#!/bin/sh

docker build -t tensorflow_gpu .
docker run --runtime=nvidia -d -p 0.0.0.0:8888:8888 -p 0.0.0.0:6006:6006 -v /data/Coursera/Advanced_Machine_Learning/Introduction_to_Deep_Learning/intro-to-dl:/root --name coursera-tensorflow-gpu tensorflow_gpu
