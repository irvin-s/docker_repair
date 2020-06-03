FROM openhorizon/jetson-tx1

#AUTHOR dima@us.ibm.com
MAINTAINER dyec@us.ibm.com

COPY *.sh /tmp/

COPY cuda-8-0-local.list /etc/apt/sources.list.d/
RUN cp -p /etc/apt/trusted.gpg /etc/apt/trusted.gpg.orig
COPY trusted.gpg /etc/apt/

WORKDIR /var
RUN curl http://AFED.http.sjc01.cdn.softlayer.net/jetson/cuda-repo-8-0-local.tgz | tar zxv

RUN apt-get update

RUN /tmp/cuda-l4t.sh foo 8.0 8-0
RUN ln -s /usr/lib/aarch64-linux-gnu/tegra/libcuda.so.1.1 /usr/lib/aarch64-linux-gnu/tegra/libcuda.so.1
RUN echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/aarch64-linux-gnu/tegra" >> /root/.bashrc

WORKDIR /tmp
RUN curl http://AFED.http.sjc01.cdn.softlayer.net/jetson2.3/cuDNN-v5.1.zip -o /tmp/cuDNN-v5.1.zip
RUN apt-get install -y unzip
RUN unzip cuDNN-v5.1.zip
WORKDIR /tmp/cuDNN
RUN dpkg -i *.deb

RUN rm -fr /tmp/*
RUN apt-get clean
RUN rm -fr /var/cuda-repo-8-0-local
RUN rm /etc/apt/sources.list.d/cuda-8-0-local.list
RUN cp -p /etc/apt/trusted.gpg.orig /etc/apt/trusted.gpg && rm /etc/apt/trusted.gpg.orig
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/aarch64-linux-gnu/tegra
