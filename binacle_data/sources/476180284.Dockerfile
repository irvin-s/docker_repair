# MailCatcher
# @author Lorenzo Fontana <fontanalorenzo@me.com>
FROM centos:centos7

MAINTAINER Lorenzo Fontana, fontanalorenzo@me.com

RUN yum install ruby ruby-devel sqlite sqlite-devel make gcc gcc-c++ -y
RUN gem install mailcatcher --no-ri --no-rdoc
RUN yum clean all

ENTRYPOINT ["mailcatcher"]
CMD ["-f", "--ip=0.0.0.0"]
