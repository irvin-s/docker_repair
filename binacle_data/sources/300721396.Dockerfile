FROM microsoft/nanoserver
# openjdk:8-jdk-nanoserver

# Build variable to allow passing in a specific version of Elasticsearch to download
ARG ELASTICSEARCH_VERSION=6.3.0
ARG ELASTICSEARCH_SOURCE=elasticsearch-oss-${ELASTICSEARCH_VERSION}
ENV ELASTICSEARCH_PATH=elasticsearch-${ELASTICSEARCH_VERSION}

COPY sources /
# Set the JAVA_HOME environment variable to match the version copied in
RUN for /d %i in (jdk*) do setx /m JAVA_HOME %~fi

# Download and extract Elasticsearch
SHELL ["powershell.exe", "-Command"]

ADD ["https://artifacts.elastic.co/downloads/elasticsearch/${ELASTICSEARCH_SOURCE}.zip", "/"]
RUN Expand-Archive -Path \$($Env:ELASTICSEARCH_SOURCE).zip -DestinationPath \ ; \
    Remove-Item -Path \$($Env:ELASTICSEARCH_SOURCE).zip ;

# ELASTIC_HOME is used by the runelasticsearch.cmd file to launch Elasticsearch.
ENV ELASTIC_HOME C:\\${ELASTICSEARCH_PATH}

COPY elasticsearch.yml ${ELASTIC_HOME}/config/

# Create a data volume and map it to the G: drive, allowing Java to call Path.toRealPath() successfully
VOLUME c:/data
RUN Set-Variable -Name 'regpath' -Value 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices' ; \
    Set-ItemProperty -path $regpath -Name 'G:' -Value '\??\C:\data' -Type String ;

ENV ES_JAVA_OPTS -Xms512m -Xmx512m

COPY RunElasticSearch.cmd /
CMD ["C:/RunElasticSearch.cmd"]

EXPOSE 9200 9300
