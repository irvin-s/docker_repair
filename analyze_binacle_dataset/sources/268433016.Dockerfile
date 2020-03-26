
# FROM jupyter/scipy-notebook

# MAINTAINER Jupyter Project <jupyter@googlegroups.com>

RUN sudo docker pull qianmao/cs503_tensorflow_jupyter


# FROM jupyter/scipy-notebook

# MAINTAINER Jupyter Project <jupyter@googlegroups.com>


# # Install Python 2 Tensorflow
# RUN conda install --quiet --yes -n python3 'tensorflow=1.0.1'

# sudo docker build . -t yifant/cs503_tensorflow_jupyter
# sudo docker login
# sudo docker push yifant/cs503_tensorflow_jupyter

# docker run -it --rm -p 8888:8888 yifant/cs503_tensorflow_jupyter