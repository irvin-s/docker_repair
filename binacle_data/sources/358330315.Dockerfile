FROM dhub.yunpro.cn/kuizhi/codis-base
MAINTAINER kuizhi.feng

ADD ./scripts/entrypoint/codis/config-setting.sh ./scripts/entrypoint/codis/dashboard-start.sh /project/

CMD sh /project/dashboard-start.sh

EXPOSE 18087