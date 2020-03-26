FROM dhub.yunpro.cn/kuizhi/codis-base
MAINTAINER kuizhi.feng

################## config file   ##################
ADD ./scripts/entrypoint/codis/config-setting.sh ./scripts/entrypoint/codis/proxy-start.sh  /project/

CMD sh /project/proxy-start.sh