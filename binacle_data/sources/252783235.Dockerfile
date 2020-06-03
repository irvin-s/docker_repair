FROM dclong/ubuntu_b  
  
ENV DEBIAN_FRONTEND=noninteractive  
  
# timezone and locale  
ENV TZ=Asia/Shanghai  
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \  
&& echo $TZ > /etc/timezone  
  
RUN locale-gen zh_CN.UTF-8  
ENV LANG=zh_CN.UTF-8 LANGUAGE=zh_CN:zh LC_ALL=zh_CN.UTF-8  

