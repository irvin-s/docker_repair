FROM registry.cn-hangzhou.aliyuncs.com/choerodon-tools/frontbase:0.7.0

ENV PRO_API_HOST gateway.choerodon.com.cn
ENV PRO_AGILE_HOST localhost:8060
ENV PRO_CLIENT_ID agile
ENV PRO_LOCAL true
ENV PRO_TITLE_NAME Choerodon
ENV PRO_HEADER_TITLE_NAME Choerodon
ENV PRO_COOKIE_SERVER choerodon.com.cn
ENV PRO_HTTP http

RUN echo "Asia/shanghai" > /etc/timezone;
ADD agile/dist /usr/share/nginx/html
COPY agile/agile-structure/agile-enterpoint.sh /usr/share/nginx/html
COPY menu.yml /usr/share/nginx/html/menu.yml
COPY dashboard.yml /usr/share/nginx/html/dashboard.yml
COPY agile/node_modules/choerodon-front-boot/structure/menu /usr/share/nginx/html/menu
COPY agile/node_modules/choerodon-front-boot/structure/dashboard /usr/share/nginx/html/dashboard
RUN chmod 777 /usr/share/nginx/html/agile-enterpoint.sh
ENTRYPOINT ["/usr/share/nginx/html/agile-enterpoint.sh"]
CMD ["nginx", "-g", "daemon off;"]


EXPOSE 80
