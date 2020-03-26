FROM nvidia/cuda:8.0-devel
ARG DEBIAN_FRONTEND=noninteractive
COPY heart.sh /root/
WORKDIR /etc/apt
#更换国内源
COPY sources.list* /etc/apt/

RUN	apt-get update \
	&& apt-get install -y apt-transport-https \	
	&& cp sources.list.tuna.s4 sources.list \
	&& apt-get update \
	&& apt-get -y install apt-utils locales \
	&& locale-gen zh_CN.UTF-8 \

#更改时区
	&& rm -f /etc/localtime \
	&& ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
#安装一些常用工具
	&& apt-get -y install nano git curl wget openssh-server \
		net-tools iputils-ping sudo htop ttf-wqy-microhei \
		zsh tcpdump iptables cron cpio tree 
#更改字符编码
ENV LANG=zh_CN.UTF-8 LC_ALL=zh_CN.UTF-8

#暴露ssh端口
EXPOSE 22

# 进一步安装软件
RUN apt-get update \
#安装基本桌面
	&& apt-get install -y xfce4 xfce4-terminal vnc4server \
#安装一些桌面插件：键盘配置、截图、解压、记事本、图像查看器、视频查看器、剪切历史记录查看、网络
	&& apt-get install -y xfce4-xkb-plugin xfce4-screenshooter thunar-archive-plugin \
		mousepad ristretto parole xfce4-clipman-plugin xfce4-netload-plugin \
#安装一些桌面应用和软件
	&& apt-get install -y fcitx-googlepinyin firefox git-gui filezilla \
	&& apt-get autoclean autoremove

