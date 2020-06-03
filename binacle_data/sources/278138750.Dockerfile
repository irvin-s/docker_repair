FROM grafana/grafana

COPY root /

RUN grafana-cli plugins install grafana-worldmap-panel
