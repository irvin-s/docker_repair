FROM python:2-alpine  
  
ENV MIRROR_URL=http://mirrors.ustc.edu.cn/alpine/ \  
MIRROR_URL_BACKUP=http://alpine.gliderlabs.com/alpine/ \  
MIRROR_URL_SLOWEST=http://dl-cdn.alpinelinux.org/alpine/ \  
TIME_ZONE=Asia/Shanghai  
  
RUN echo '' > /etc/apk/repositories && \  
echo "${MIRROR_URL}v3.3//main" >> /etc/apk/repositories && \  
echo "${MIRROR_URL}v3.3//community" >> /etc/apk/repositories && \  
echo '185.31.17.249 github.com' >> /etc/hosts && \  
echo '202.141.160.110 mirrors.ustc.edu.cn' >> /etc/hosts && \  
apk add --no-cache \  
gcc \  
musl-dev \  
bash \  
tzdata \  
postgresql-dev \  
&& \  
echo "${TIME_ZONE}" > /etc/timezone && \  
ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime  
  
RUN echo 'alias ll="ls -al"' >> ~/.bashrc && echo >> ~/.bashrc  
  

