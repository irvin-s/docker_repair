FROM ubuntu
MAINTAINER Matt Erasmus <code@zonbi.org>
RUN addgroup spiderfoot 
RUN useradd -r -g spiderfoot -d /opt/spiderfoot -s /sbin/nologin -c "SpiderFoot User" spiderfoot
RUN apt-get update
RUN apt-get install -yq python2.7 python-pip python-m2crypto wget libxml2-dev libssl-dev zlib1g-dev zlib1g \
	python2.7-dev libxslt1-dev
RUN wget -q "http://sourceforge.net/projects/spiderfoot/files/spiderfoot-2.6.1-src.tar.gz/download" -O /tmp/a
RUN tar zxf /tmp/a -C /opt/
RUN mv /opt/spiderfoot-2.6.1 /opt/spiderfoot
RUN chown spiderfoot:spiderfoot -R /opt/spiderfoot
RUN pip install lxml netaddr cherrypy mako
WORKDIR /opt/spiderfoot
USER spiderfoot
EXPOSE 8080
ENTRYPOINT ["/usr/bin/python"]
CMD ["sf.py", "0.0.0.0:8080"]
