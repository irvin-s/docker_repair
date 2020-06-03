FROM ubuntu:15.04
MAINTAINER datawarehouse <aus-eng-data-warehouse@rmn.com>

RUN apt-get update
RUN apt-get install -y python-dev python-pip libpq-dev vim curl mlocate

RUN apt-get install -y wget

RUN mkdir -p /home/root
RUN cd /home/root
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN /usr/local/bin/pip install awscli

RUN apt-get install -y libmagic-dev \
    libxml2-dev \
    libxmlsec1-dev \
    swig \
    libxslt1-dev

ADD /src/python/requirements.txt /src/python/requirements.txt

RUN pip install -r /src/python/requirements.txt

# see https://github.com/onelogin/python-saml/issues/30 \
RUN if [ -f /usr/bin/xmlsec1-config ]; then sed -i 's/LIBLTDL=1 -I/LIBLTDL=1 -DXMLSEC_NO_SIZE_T -I/' /usr/bin/xmlsec1-config  ; fi
RUN pip uninstall -y dm.xmlsec.binding
RUN pip install dm.xmlsec.binding

ADD src/python /src/python

RUN mkdir -p /mnt/docker-volumes/dart-web-static
RUN cp -rp /src/python/dart/web/ui/dist/* /mnt/docker-volumes/dart-web-static/
VOLUME /mnt/docker-volumes

RUN updatedb # index all file for a quick search with 'locate'

WORKDIR /src/python/dart/web

ENV PYTHONPATH=/src/python:${PYTHONPATH}

EXPOSE 9191

CMD ["uwsgi", "--ini", "/src/python/dart/web/uwsgi.ini"]
