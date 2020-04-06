#!/bin/sh

ldconfig
# jupyter notebook --ip=0.0.0.0 --no-browser --allow-root &
xvfb-run -s "-screen 0 1400x900x24" jupyter notebook --ip=0.0.0.0 --no-browser --allow-root &
tensorboard --logdir /root/logs
