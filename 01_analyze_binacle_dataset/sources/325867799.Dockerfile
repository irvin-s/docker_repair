FROM registry.cn-beijing.aliyuncs.com/rogerchen/simpledet:cuda9

#RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
#    APT_INSTALL="apt-get install -y --no-install-recommends" && \
#    apt-get update && DEBIAN_FRONTEND=noninteractive $APT_INSTALL python3-pip python3-dev libffi-dev libssl-dev python3-setuptools 

#COPY ./mxnext mxnext

#RUN pip3 install 'git+https://github.com/RogerChern/mxnext.git@pkg' 

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    APT_INSTALL="apt-get install -y --no-install-recommends" && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL ca-certificates
