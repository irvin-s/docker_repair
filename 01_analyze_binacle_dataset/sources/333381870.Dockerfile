FROM docker.io/centos

#inception
RUN yum -y install wget git gcc gcc-c++ make cmake openssl-devel ncurses-devel m4\
    && cd /opt \  
    && git clone https://github.com/hhyo/inception.git \
    && rpm -i /opt/inception/dockersrc/bison-2.7-4.el7.x86_64.rpm \  
    && mv /opt/inception/dockersrc/inc.cnf /etc \
    && cd inception \
    && ./inception_build.sh debug \
    && yum -y install https://repo.percona.com/yum/percona-release-latest.noarch.rpm \
    && yum -y install percona-toolkit \
#修改中文支持
    && rm -rf /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \ 
    && yum -y install kde-l10n-Chinese && yum -y reinstall glibc-common \ 
    && localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 
ENV LC_ALL zh_CN.utf8 #设置环境变量

#port
EXPOSE 6669

#start service
ENTRYPOINT nohup /opt/inception/debug/mysql/bin/Inception --defaults-file=/etc/inc.cnf && bash
