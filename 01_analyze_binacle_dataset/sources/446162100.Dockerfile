# Ubuntu 12.04 (precise) + ZeroVM + Python
#
# BUILDAS sudo docker build -t zerovm_python .
# RUNAS sudo docker -i -t run zerovm_python <python file>
#

FROM ubuntu
MAINTAINER Nick Lothian nick.lothian@gmail.com

RUN mkdir -p /opt/zerovm

RUN apt-get -y install sudo
RUN apt-get -y install wget

RUN useradd zerovmuser

ADD libpgm-5.1-0_5.1.118-1~dfsg-0.1ubuntu1_amd64.deb /opt/zerovm/libpgm-5.1-0_5.1.118-1~dfsg-0.1ubuntu1_amd64.deb
ADD libzmq3_4.0.1-ubuntu1_amd64.deb /opt/zerovm/libzmq3_4.0.1-ubuntu1_amd64.deb

# ADD python.tar /opt/zerovm/python.tar # prior to Docker 0.8 this would not uncompress the tar file
# This is a work around
ADD python.tar /opt/zerovm/pythondir
RUN tar -cvf /opt/zerovm/python.tar -C /opt/zerovm/pythondir .


ADD helloworld.py /opt/zerovm/helloworld.py

RUN chown -R zerovmuser:zerovmuser /opt/zerovm # not clear why this is needed. May be due to work around above

RUN dpkg -i /opt/zerovm/libpgm-5.1-0_5.1.118-1~dfsg-0.1ubuntu1_amd64.deb
RUN dpkg -i /opt/zerovm/libzmq3_4.0.1-ubuntu1_amd64.deb

RUN wget -O- http://packages.zerovm.org/apt/ubuntu/zerovm.pkg.key | apt-key add -

RUN echo "deb http://packages.zerovm.org/apt/ubuntu/ precise main" > /etc/apt/sources.list.d/zerovm-precise.list


RUN apt-get update

RUN apt-get -y install zerovm

RUN apt-get -y install zerovm-cli


#CMD ["@/opt/zerovm/helloworld.py"]
#ENTRYPOINT ["sudo", "-u", "zerovmuser", "zvsh", "--zvm-image", "/opt/zerovm/python.tar", "python"]

