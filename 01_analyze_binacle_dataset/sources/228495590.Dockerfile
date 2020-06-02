FROM paas/baseimage:1.0.0
MAINTAINER ZaneZeng

RUN \
  apt-get update && \
  apt-get -y install python && \ 
  apt-get -y install haproxy && \
  apt-get -y install libcurl4-gnutls-dev && \
  apt-get -y install python-dev

COPY python /python

RUN sudo python /python/get-pip.py
RUN pip install requests
RUN pip install mako
RUN pip install pycurl

WORKDIR /python/urlgrabber
RUN python ./setup.py install
WORKDIR /

COPY loadbalancer.py /loadbalancer.py
COPY reload.sh /reload.sh
COPY template.cfg /template.cfg
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY haproxy.cfg /etc/haproxy/haproxy.cfg

RUN chmod a+x /loadbalancer.py
RUN chmod a+x /reload.sh
RUN chmod a+x /docker-entrypoint.sh
RUN chmod 755 /etc/haproxy/haproxy.cfg

EXPOSE 80 1936
ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]

CMD ["/bin/bash"]
