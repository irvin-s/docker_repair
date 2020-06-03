# 基于官方nginx镜像  
FROM nginx:alpine  
  
# 维护者  
LABEL maintainer="Niuren.Zhu <niuren.zhu@icloud.com>"  
  
# 安装工具  
RUN set -x \  
# 更新源  
&& apk update \  
# 安装解压、网络请求  
&& apk add \--no-cache unzip curl wget \  
# 删除源  
&& rm -rf /var/cache/apk/*  
  
# 环境变量-NGINX目录  
ENV NGINX_HOME /usr/share/nginx  
# 创建数据文件夹  
RUN set -x \  
&& mkdir -p ${NGINX_HOME}  
  
# 拷贝脚本  
COPY deploy_apps.sh ${NGINX_HOME}/deploy_apps.sh  
RUN chmod 775 ${NGINX_HOME}/*.sh  
  
# 设置工作目录  
WORKDIR ${NGINX_HOME}

