FROM lighthouse.examples.base

COPY configs/haproxy.yaml /etc/lighthouse/balancers/
COPY configs/discovery/zookeeper.yaml /etc/lighthouse/discovery/
COPY configs/clusters/cache.yaml /etc/lighthouse/clusters/
COPY configs/services/api_widgets.yaml /etc/lighthouse/services/

RUN virtualenv -p /usr/bin/python2.7 /opt/venvs/widgets
RUN . /opt/venvs/widgets/bin/activate; pip install flask redis
COPY apps/widgets.py /opt/venvs/widgets/bin/

COPY supervisord/widgets.conf /etc/supervisord/conf.d/

# widgets http port
EXPOSE 8000
