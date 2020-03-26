FROM lighthouse.examples.base

RUN apt-get install -y curl

COPY configs/haproxy.yaml /etc/lighthouse/balancers/
COPY configs/discovery/zookeeper.yaml /etc/lighthouse/discovery/
COPY configs/clusters/webapp.yaml /etc/lighthouse/clusters/
COPY configs/clusters/api_widgets.yaml /etc/lighthouse/clusters/
COPY configs/clusters/api_sprockets.yaml /etc/lighthouse/clusters/

RUN mkdir -p /var/log/supervisor/lighthouse
COPY supervisord/lighthouse.conf /etc/supervisord/conf.d/


# webapp http port
EXPOSE 8000

# stuff api http port
EXPOSE 8080
