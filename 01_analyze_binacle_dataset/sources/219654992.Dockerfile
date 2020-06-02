FROM lighthouse.examples.base

COPY configs/haproxy.yaml /etc/lighthouse/balancers/
COPY configs/discovery/zookeeper.yaml /etc/lighthouse/discovery/
COPY configs/clusters/cache.yaml /etc/lighthouse/clusters/
COPY configs/services/webapp.yaml /etc/lighthouse/services/

RUN virtualenv -p /usr/bin/python2.7 /opt/venvs/webapp
RUN . /opt/venvs/webapp/bin/activate; pip install flask redis
COPY apps/webapp.py /opt/venvs/webapp/bin/

COPY supervisord/webapp.conf /etc/supervisord/conf.d/

# webapp port
EXPOSE 8000
