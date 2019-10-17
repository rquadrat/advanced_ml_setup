#!/bin/sh

jupyter notebook --ip=0.0.0.0 --no-browser --allow-root &
tensorboard --logdir /root/logs
