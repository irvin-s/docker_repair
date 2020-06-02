from debian:stretch
MAINTAINER ugurarpaci@gmail.com
RUN apt-get update
RUN apt-get install gcc make cmake gettext -y
ADD . /opt/httping
WORKDIR /opt/httping
RUN make
RUN mv httping /usr/local/bin && chmod +x /usr/local/bin/httping
ENTRYPOINT ["httping"]
