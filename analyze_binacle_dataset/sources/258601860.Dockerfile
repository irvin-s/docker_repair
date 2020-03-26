FROM debian
MAINTAINER Dimitris Zervas <dzervas@dzervas.gr>

RUN echo "deb http://repo.powerdns.com/debian jessie-auth-40 main" > /etc/apt/sources.list.d/pdns.list && \
	echo "Package: pdns-*\nPin: origin repo.powerdns.com\nPin-Priority: 600" > /etc/apt/preferences.d/pdns && \
	apt-get update && apt-get install -y curl && curl https://repo.powerdns.com/FD380FBB-pub.asc | apt-key add - && \
	apt-get update && apt-get install -y pdns-server pdns-backend-sqlite3 && rm /etc/powerdns/pdns.d/pdns.simplebind.conf

COPY create_db.sql /create_db.sql
COPY start.sh /start.sh

EXPOSE 53
EXPOSE 53/udp
EXPOSE 80

VOLUME [ "/etc/powerdns/sqlite3/" ]
CMD ["/start.sh"]
