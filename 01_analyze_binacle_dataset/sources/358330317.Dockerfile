FROM dhub.yunpro.cn/kuizhi/codis-base
MAINTAINER kuizhi.feng

################## config file   ##################
ADD ./scripts/entrypoint/codis/server-start.sh ./conf/codis/redis.default.conf /project/
CMD sh /project/server-start.sh
EXPOSE 6379