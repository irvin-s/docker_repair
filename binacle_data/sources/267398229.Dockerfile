FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
MAINTAINER Thomas Keck <thomas.keck2@kit.edu>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install apt-utils && \
    apt-get -y install python3-pip python3-virtualenv libfreetype6-dev libpng12-dev pkg-config llvm-4.0 libedit-dev git npm nodejs

# Create tutorial users
RUN for i in `seq 1 30`; do useradd -ms /bin/bash kseta_tutorial_$i; echo "kseta_tutorial_$i:********" | chpasswd; done 

ENV LANG C.UTF-8

# Update python
RUN pip3 install --system setuptools==36.2.7 && \
    pip3 install --system pip==9.0.1

# Install basic packages
RUN pip3 install numpy==1.13.1 && \
    pip3 install jupyter==1.0.0 && \
    pip3 install matplotlib==2.0.2 && \
    pip3 install scipy==0.19.1 && \
    pip3 install pandas==0.20.2 && \
    pip3 install sympy==1.1.1 && \
    pip3 install scikit-learn==0.19.0 && \
    pip3 install jupyterhub==0.7.2

# Install further packages
RUN pip3 install xgboost==0.6a2 && \
    pip3 install theano==0.10.0b1 && \
    pip3 install tensorflow-gpu==1.3.0 && \
    pip3 install Cython==0.26 && \
    pip3 install numexpr==2.6.2 && \
    pip3 install WordCloud==1.3.1 && \
    pip3 install llvmlite==0.20.0 && \
    pip3 install numba==0.35.0 && \
    pip3 install hep_ml==0.5.0 && \
    pip3 install scikit-optimize==0.4 && \
    pip3 install keras==2.0.8

RUN npm install -g configurable-http-proxy

RUN mkdir -p /srv/jupyterhub/
WORKDIR /srv/jupyterhub/

# Checkout the course git repository
RUN git clone https://github.com/thomaskeck/MultivariateClassificationLecture.git && \
    for i in `seq 1 30`; do cp -r MultivariateClassificationLecture/exercises /home/kseta_tutorial_$i/; chown -R kseta_tutorial_$i /home/kseta_tutorial_$i/exercises; done 

# Fix broken symlinks link
RUN ln -s /usr/bin/nodejs /usr/bin/node 

RUN apt-get install -y wget nano locate && updatedb
RUN echo "/usr/lib/nvidia-375" >> /etc/ld.so.conf.d/nvidia.conf
# Using ldconfig doesn't work, don't know why
# RUN ldconfig
RUN echo '#!/bin/bash' >> /bin/startup && echo "ldconfig && jupyterhub" >> /bin/startup && chmod +x /bin/startup

EXPOSE 8000

CMD ["startup"]

#docker build -t myjupyterhub .
#export NVIDIA_SO=$(\ls /usr/lib/nvidia-375/libnvidia* | xargs -I{} echo '-v {}:{}')
#export DEVICES=$(\ls /dev/nvidia* | xargs -I{} echo '--device {}:{}')
#export CUDA_SO=$(\ls /usr/lib/x86_64-linux-gnu/libcuda.* | xargs -I{} echo '-v {}:{}')
#docker run -p 8005:8000 $CUDA_SO $NVIDIA_SO $DEVICES -it myjupyterhub:latest

