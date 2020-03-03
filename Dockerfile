FROM tensorflow/tensorflow:1.2.1-gpu-py3

ARG DEBIAN_FRONTEND=noninteractive

# install apt packages
RUN apt-get update && \
    apt-get install -yq python3-pip htop nano git wget libglib2.0-0 ffmpeg python3-tk \
    unzip cmake zlib1g-dev libjpeg-dev xvfb libav-tools xorg-dev python-opengl swig3.0 \
    libopenblas-dev liblapack-dev libsdl2-dev libboost-all-dev graphviz gcc g++ && \
    ln -s /usr/bin/swig3.0 /usr/bin/swig



# install python modules
COPY requirements.txt .
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
RUN pip3 install GPyOpt==1.2.1 \
                 gym[atari] \
                 https://github.com/Lasagne/Lasagne/archive/master.zip \
                 https://github.com/yandexdataschool/AgentNet/archive/master.zip
RUN pip3 install gym[box2d]

# setup juptyer
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension
RUN jupyter contrib nbextension install --user
RUN jupyter nbextension enable codefolding/main
RUN echo "c.NotebookApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.port = 8080" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py

COPY entrypoint.sh /usr/local/bin/
WORKDIR /root
EXPOSE 6006 8888
# CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
CMD ["/usr/local/bin/entrypoint.sh"]
