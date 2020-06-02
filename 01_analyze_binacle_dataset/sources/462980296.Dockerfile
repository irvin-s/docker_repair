FROM loads/alpine:3.8

LABEL maintainer="john@johng.cn"

###############################################################################
#                                INSTALLATION
###############################################################################

# 设置固定的项目路径
ENV WORKDIR /var/www/gf-home

# 添加应用可执行文件，并设置执行权限
ADD ./gf-home $WORKDIR/main
RUN chmod +x  $WORKDIR/main

# 添加静态文件、配置文件、模板文件
ADD public   $WORKDIR/public
ADD config   $WORKDIR/config
ADD template $WORKDIR/template

###############################################################################
#                                   START
###############################################################################
WORKDIR $WORKDIR
CMD main