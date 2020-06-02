FROM nginx:1.9.9

ENV dws_api_proxy dws_back-end_1:8080

RUN rm /etc/nginx/conf.d/default.conf
COPY dws-dist/ /data/dws/
COPY dws.conf /etc/nginx/conf.d/

COPY start.sh /usr/bin/start.sh
CMD ["/bin/bash", "/usr/bin/start.sh"]