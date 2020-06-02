
#pull base image

FROM centos:7

MAINTAINER preluoc "pre_luoc@sina.com"

#install git
RUN yum install -y git

WORKDIR /root/

RUN git clone https://github.com/Tencent/Tars.git

RUN git clone https://github.com/Tencent/rapidjson.git

RUN cp -r /root/rapidjson /root/Tars/cpp/thirdparty/

RUN yum install -y gcc

RUN yum install -y gcc-c++

RUN yum install -y make

RUN yum install -y iproute

RUN yum install -y which

##安装glibc-devel
RUN yum install -y glibc-devel

##安装flex、bison
RUN yum install -y flex bison

# mysql 支持库
RUN yum install -y ncurses-devel
RUN yum install -y zlib-devel


RUN yum install -y perl

RUN yum install -y perl-Module-Install.noarch


#中文乱码
RUN  yum install -y kde-l10n-Chinese

RUN  yum reinstall -y glibc-common

RUN  localedef -c -f UTF-8 -i zh_CN zh_CN.utf8

ENV  LC_ALL zh_CN.utf8


#拷贝资源
COPY res /root/res/

RUN  yum install -y wget

RUN  yum install -y cmake

RUN  yum install -y maven

RUN  yum install -y java

COPY init /root/init/

COPY entrypoint.sh /sbin/

ENTRYPOINT  ["/bin/bash","/sbin/entrypoint.sh"]

CMD ["start"]

#Expose ports
EXPOSE 8080
