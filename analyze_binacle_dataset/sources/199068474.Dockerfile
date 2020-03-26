FROM ubuntu:14.04

#安装python, 这步可以省略，或添加其他依赖
RUN apt-get update
RUN apt-get install -y python

#创建脚本路径
RUN mkdir /code
WORKDIR /code

#复制要运行的代码到镜像中，包括cron配置文件
ADD . /code

#设置cron脚本
RUN crontab /code/crontabfile

#安装rsyslog
RUN apt-get -y install rsyslog

#复制crontabfile到/etc/crontab
RUN cp /code/crontabfile /etc/crontab
RUN touch /var/log/cron.log

#将run.sh设置为可执行
RUN chmod +x /code/run.sh

WORKDIR /code

CMD ["bash","/code/run.sh"]
