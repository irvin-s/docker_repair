FROM xzdbd/nginx

MAINTAINER xzdbd <xzdbd@sina.com>

ENV ACMEDIR /root

VOLUME $ACMEDIR/.acme.sh

COPY ./nginx.conf /usr/local/nginx/conf/nginx.conf

EXPOSE 80

CMD /usr/local/nginx/sbin/nginx -g 'daemon off;'
	 