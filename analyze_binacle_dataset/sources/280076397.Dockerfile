FROM ceshine/cuda-pytorch:0.2.0

MAINTAINER CeShine Lee <ceshine@ceshine.net>

RUN  pip install --upgrade pip tqdm && \
     pip install tensorflow-gpu==1.3.0

RUN conda install -y --quiet jupyter mkl-service matplotlib && \
    conda clean -tipsy

# Jupyter
EXPOSE 8888
CMD jupyter notebook --ip=0.0.0.0 --port=8888
