FROM centos:7
MAINTAINER kent72 <kenthuang72@gmail.com>
RUN echo "root:docker" | chpasswd 
RUN yum install -y wget
RUN wget https://github.com/kendou/lantern/raw/master/lantern_linux_amd64 -O lantern
RUN chmod +x lantern
EXPOSE 8787
ENTRYPOINT [ "/lantern", "--addr", "0.0.0.0:8787" ]
