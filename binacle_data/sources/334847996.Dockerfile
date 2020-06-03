FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

RUN apt-get update && apt-get install -y wget ca-certificates \
    git curl vim python3-dev python3-pip \
    libfreetype6-dev libpng12-dev libgtk2.0-dev

RUN pip3 install --upgrade pip
RUN pip3 install tensorflow-gpu==1.4
RUN pip3 install tensorflow-tensorboard
RUN pip3 install numpy pandas sklearn matplotlib seaborn jupyter
RUN pip3 install jupyter-tensorboard tqdm
RUN pip3 install keras nltk gensim
RUN pip3 install h5py tqdm
RUN pip3 install jupyterlab

RUN ["mkdir", "notebooks"]
COPY jupyter_notebook_config.py /root/.jupyter/
COPY run_jupyter.sh /

# Jupyter and Tensorboard ports
EXPOSE 8888 6006

# Store notebooks in this mounted directory
VOLUME /notebooks

RUN chmod +x /run_jupyter.sh
CMD ["/run_jupyter.sh"]
