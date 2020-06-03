FROM python:2-alpine
MAINTAINER Dimitris Zervas <dzervas@dzervas.gr>

RUN apk add --update sudo build-base git libffi-dev openldap-dev python-dev && \
	rm -rf /var/cache/apk/*

RUN git clone https://github.com/ngoduykhanh/PowerDNS-Admin /src
WORKDIR /src

RUN pip install -r requirements.txt

COPY config.py /src/
COPY create_admin.py /src/
COPY start.sh /start.sh

EXPOSE 9393
VOLUME [ "/data" ]

CMD [ "/start.sh" ]
