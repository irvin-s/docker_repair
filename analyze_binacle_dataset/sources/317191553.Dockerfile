FROM registry.cn-hangzhou.aliyuncs.com/choerodon-tools/frontbase:0.7.0

ENV PRO_API_HOST gateway.choerodon.com.cn
ENV PRO_DEVOPS_HOST localhost:8060
ENV PRO_CLIENT_ID devops
ENV PRO_LOCAL true
ENV PRO_TITLE_NAME Choerodon
ENV PRO_HEADER_TITLE_NAME Choerodon
ENV PRO_COOKIE_SERVER choerodon.com.cn
ENV PRO_HTTP http
ENV PRO_FILE_SERVER choerodon.com.cn

RUN echo "Asia/shanghai" > /etc/timezone;
ADD devops/dist /usr/share/nginx/html
COPY devops/devops-structure/devops-enterpoint.sh /usr/share/nginx/html
COPY menu.yml /usr/share/nginx/html/menu.yml
COPY dashboard.yml /usr/share/nginx/html/dashboard.yml
COPY devops/node_modules/choerodon-front-boot/structure/menu /usr/share/nginx/html/menu
COPY devops/node_modules/choerodon-front-boot/structure/dashboard /usr/share/nginx/html/dashboard
RUN chmod 777 /usr/share/nginx/html/devops-enterpoint.sh
ENTRYPOINT ["/usr/share/nginx/html/devops-enterpoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80
