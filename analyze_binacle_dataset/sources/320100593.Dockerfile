FROM alpine:latest

MAINTAINER niuyuxian <"ncc0706@gmail.com">

ENV LANG=en_US.UTF-8 \
    TZ=Asia/Shanghai \
    ROOT_PASSWORD=node

# using on arukas 
RUN echo -e "https://mirror.tuna.tsinghua.edu.cn/alpine/latest-stable/main\n" > /etc/apk/repositories

RUN apk --update add openssh \
        supervisor \
	tzdata \
	&& cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
	&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
	&& echo "root:${ROOT_PASSWORD}" | chpasswd \
	&& mkdir -p /var/logs/supervisor \
	&& mkdir -p /var/run/supervisor \
	&& rm -rf /var/cache/apk/* /tmp/*

RUN ssh-keygen -A

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]



