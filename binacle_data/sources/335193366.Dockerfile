FROM centos as builder

WORKDIR /root/

##修改镜像时区 
ENV TZ=Asia/Shanghai

##安装
RUN yum install -y git gcc gcc-c++ make wget cmake mysql mysql-devel unzip iproute which glibc-devel flex bison ncurses-devel protobuf-devel zlib-devel kde-l10n-Chinese glibc-common \
	&& ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
	&& localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 \
	&& mkdir -p /usr/local/mysql && ln -s /usr/lib64/mysql /usr/local/mysql/lib && ln -s /usr/include/mysql /usr/local/mysql/include && echo "/usr/local/mysql/lib/" >> /etc/ld.so.conf && ldconfig \
	&& cd /usr/local/mysql/lib/ && ln -s libmysqlclient.so.*.*.* libmysqlclient.a \
	# 克隆项目代码
	&& cd /root/ && git clone https://github.com/TarsCloud/Tars \
	&& cd /root/Tars/ && git submodule update --init --recursive framework && git submodule update --init --recursive web \
	&& mkdir -p /data && chmod u+x /root/Tars/framework/build/build.sh \
	&& cd /root/Tars/framework/build/ && ./build.sh all \
	&& ./build.sh install \
	&& cd /root/Tars/framework/build/ && make framework-tar \
	&& make tarsstat-tar && make tarsnotify-tar && make tarsproperty-tar && make tarslog-tar && make tarsquerystat-tar && make tarsqueryproperty-tar \
	&& mkdir -p /usr/local/app/tars/ && cp /root/Tars/framework/build/framework.tgz /usr/local/app/tars/ && cp /root/Tars/framework/build/t*.tgz /root/ \
	&& cd /usr/local/app/tars/ && tar xzfv framework.tgz && rm -rf framework.tgz \
	&& mkdir -p /usr/local/app/patchs/tars.upload \
	&& mkdir -p /root/init && cd /root/init/ \
	&& wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash \
	&& source ~/.bashrc && nvm install v8.15.1 \
	&& cp -Rf /root/Tars/web /usr/local/tarsweb \
	&& cd /usr/local/tarsweb/ && npm install --registry=https://registry.npm.taobao.org


FROM centos/systemd

WORKDIR /root/

##修改镜像时区 
ENV TZ=Asia/Shanghai
	
ENV DBIP 127.0.0.1
ENV DBPort 3306
ENV DBUser root
ENV DBPassword password

# Mysql里tars用户的密码，缺省为tars2015
ENV DBTarsPass tars2015

COPY --from=builder /usr/local/app /usr/local/app
COPY --from=builder /usr/local/tarsweb /usr/local/tarsweb
COPY --from=builder /usr/local/tars /usr/local/tars
COPY --from=builder /home/tarsproto /home/tarsproto
COPY --from=builder /root/t*.tgz /root/
COPY --from=builder /root/Tars/framework/sql /root/sql

RUN yum install -y wget mysql unzip iproute which flex bison protobuf zlib kde-l10n-Chinese glibc-common \
	&& ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
	&& localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 \
	&& mkdir -p /usr/local/mysql && ln -s /usr/lib64/mysql /usr/local/mysql/lib && echo "/usr/local/mysql/lib/" >> /etc/ld.so.conf && ldconfig \
	&& cd /usr/local/mysql/lib/ && ln -s libmysqlclient.so.*.*.* libmysqlclient.a \
	&& wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash \
	&& source ~/.bashrc && nvm install v8.15.1 \
	&& cd /usr/local/tarsweb/ && npm install -g pm2 --registry=https://registry.npm.taobao.org \
	&& yum clean all && rm -rf /var/cache/yum

# 是否将开启Tars的Web管理界面登录功能，预留，目前没用
ENV ENABLE_LOGIN false

# 是否将Tars系统进程的data目录挂载到外部存储，缺省为false以支持windows下使用
ENV MOUNT_DATA false

# 网络接口名称，如果运行时使用 --net=host，宿主机网卡接口可能不叫 eth0
ENV INET_NAME eth0

# 中文字符集支持
ENV LC_ALL "zh_CN.UTF-8"

VOLUME ["/data"]
	
##拷贝资源
COPY install.sh /root/init/
COPY entrypoint.sh /sbin/

ADD confs /root/confs

RUN chmod 755 /sbin/entrypoint.sh
ENTRYPOINT [ "/sbin/entrypoint.sh", "start" ]

#Expose ports
EXPOSE 3000
