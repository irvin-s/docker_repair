FROM microsoft/windowsservercore

# Build variable to allow passing in a specific version of Elasticsearch to download
ARG KIBANA_VERSION=6.3.2
ARG KIBANA_SOURCE=kibana-${KIBANA_VERSION}-windows-x86_64

SHELL ["powershell.exe", "-Command"]

# Download and extract Kibana
ADD ["https://artifacts.elastic.co/downloads/kibana/${KIBANA_SOURCE}.zip", "/"]

# Extracting the archive can take a while unless this step is cached already
RUN powershell.exe -Command \
  Expand-Archive -Path \$($Env:KIBANA_SOURCE).zip -DestinationPath \ ; \
  Remove-Item -Path \$($Env:KIBANA_SOURCE).zip;

# ELASTIC_HOME is used by the runelasticsearch.cmd file to launch Elasticsearch.
ENV KIBANA_HOME C:\\${KIBANA_SOURCE}

COPY kibana.yml /${KIBANA_SOURCE}/config/
COPY kibana.bat /${KIBANA_SOURCE}/bin/

WORKDIR C:\\${KIBANA_SOURCE}
CMD [".\\bin\\kibana.bat"]

EXPOSE 5601
