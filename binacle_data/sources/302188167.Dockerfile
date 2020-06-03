FROM solr:7.2
WORKDIR /tmp
RUN curl -s -k -o zm-solr-docker-deps.tar.gz 'https://docker.zimbra.com.s3.amazonaws.com/assets/zm-solr-docker-deps-20180423.tar.gz'
RUN tar -C / --no-overwrite-dir --strip-components=1 -xf zm-solr-docker-deps.tar.gz
RUN rm zm-solr-docker-deps.tar.gz
RUN cp -r /opt/solr/server/solr /opt/solr/init-solr-home
COPY solr/entrypoint /opt/solr/entrypoint
WORKDIR /opt/solr
ENTRYPOINT ./entrypoint
EXPOSE 8983 9983
