FROM dockerfile/java:oracle-java7

MAINTAINER Andreas Jung <info@zopyx.com>

RUN apt-get update
RUN apt-get install -y \
    python-virtualenv \
    python \
    curl expect \
    build-essential \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libbz2-dev \
    zlib1g-dev \
    python-setuptools \
    python-dev \
    libjpeg62-dev \
    libreadline-gplv2-dev \
    python-imaging \
    wv \
    python-dev \
    libxml2-dev \
    libxslt1-dev \
    git-core  


RUN useradd -ms /bin/bash plone

USER plone
WORKDIR /home/plone

RUN curl -LO http://downloads.sourceforge.net/exist/Stable/2.2/eXist-db-setup-2.2.jar
ADD exist-setup.cmd /home/plone/exist-setup.cmd
RUN expect -f exist-setup.cmd
RUN rm eXist-db-setup-2.2.jar exist-setup.cmd
ENV EXIST_HOME /home/plone/exist


RUN virtualenv .
RUN bin/pip install grampg
RUN git clone https://github.com/xml-director/xmldirector.plonecore.git  
WORKDIR xmldirector.plonecore
RUN git pull
RUN ../bin/python bootstrap.py --setuptools-version=7.0 --version=2.2.5 -c buildout-plone-4.3.cfg
RUN bin/buildout -c demo.cfg

EXPOSE 8080 8443 12020
