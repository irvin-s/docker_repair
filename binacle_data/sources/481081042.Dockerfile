FROM httpd:2.4
MAINTAINER ct

RUN apt-get update && \
    apt-get -t jessie-backports install -y apache2-dev libssl-dev libffi-dev gcc postgresql-client libpq-dev python3 python3-dev python3-pip wget --no-install-recommends

#RUN wget https://github.com/GrahamDumpleton/mod_wsgi/archive/4.5.0.tar.gz && tar xvfz 4.5.0.tar.gz && \
#    cd mod_wsgi-4.5.0 && ./configure --with-apxs=/usr/local/apache2/bin/apxs && make && make install

RUN pip3 install mod_wsgi
RUN cp /usr/local/lib/python3.4/dist-packages/mod_wsgi/server/mod_wsgi-py34.cpython-34m.so /usr/local/apache2/modules/mod_wsgi.so

COPY ./observatory/requirements.txt /observatory/requirements.txt

RUN pip3 install -r /observatory/requirements.txt

COPY ./observatory /observatory

RUN mv /observatory/certs/observatory.pem /etc/ssl/certs/observatory.pem && \
    mv /observatory/certs/observatory_key.pem /etc/ssl/private/observatory_key.pem && \
    mv /observatory/certs/observatory_chain.pem /etc/ssl/certs/observatory_chain.pem

RUN mkdir /static

RUN python3 /observatory/manage.py collectstatic --noinput

RUN cp /observatory/httpd.conf /usr/local/apache2/conf/httpd.conf
