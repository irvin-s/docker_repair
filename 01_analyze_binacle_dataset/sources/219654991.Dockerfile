FROM lighthouse.examples.base

COPY configs/haproxy.yaml /etc/lighthouse/balancers/
COPY configs/discovery/zookeeper.yaml /etc/lighthouse/discovery/
COPY configs/clusters/cache.yaml /etc/lighthouse/clusters/
COPY configs/clusters/proxy.yaml /etc/lighthouse/clusters/
COPY configs/services/api_sprockets.yaml /etc/lighthouse/services/

RUN virtualenv -p /usr/bin/python2.7 /opt/venvs/sprockets
RUN . /opt/venvs/sprockets/bin/activate; pip install flask redis requests
COPY apps/sprockets.py /opt/venvs/sprockets/bin/

COPY supervisord/sprockets.conf /etc/supervisord/conf.d/

# sprockets http port
EXPOSE 8000
