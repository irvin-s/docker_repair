FROM phusion/baseimage

## Add dashboards and script to load them
RUN mkdir -p /etc/kibana/dashboards
COPY dashboards /etc/kibana/dashboards
ADD ./loadDashboards.sh /tmp/loadDashboards.sh
RUN chmod +x /tmp/loadDashboards.sh

## Start script
ADD ./setup.sh /tmp/setup.sh
RUN chmod +x /tmp/setup.sh
CMD [ "/tmp/setup.sh" ]