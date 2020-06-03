FROM grafana/grafana
USER root
RUN apt-get  update && apt-get install -y git build-essential
WORKDIR /tmp

RUN git clone https://github.com/google/jsonnet.git
RUN cd jsonnet && make jsonnet
RUN cp jsonnet/jsonnet /usr/local/bin

RUN git clone https://github.com/grafana/grafonnet-lib.git
COPY . /tmp/
COPY ./generate_and_run.sh /generate_and_run.sh

RUN chmod +x /tmp/generate_and_run.sh
RUN mkdir -p /data/dashboards
COPY ./provisioning/dashboards/dashboard.yml /etc/grafana/provisioning/dashboards/dashboard.yml
RUN chown grafana:grafana /data/dashboards
RUN chown -R grafana:grafana /etc/grafana/provisioning/
USER grafana



ENTRYPOINT [ "/tmp/generate_and_run.sh" ]