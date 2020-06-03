FROM solr:6.5

#### Installs JTS Topology Suite 1.14

# Change directory so that our commands run inside this new directory
WORKDIR /opt/solr/server

# Downloads and unzips JTS library & moves JTS Libs to SOLR Libs and deletes intermediate files and directories
# Tries to download it three times before failing. Sometimes on slow networks, the download fails.
RUN (wget https://sourceforge.net/projects/jts-topo-suite/files/jts/1.14/jts-1.14.zip || \
    wget https://sourceforge.net/projects/jts-topo-suite/files/jts/1.14/jts-1.14.zip || \
    wget https://sourceforge.net/projects/jts-topo-suite/files/jts/1.14/jts-1.14.zip) \
    && unzip -o jts-1.14.zip -d jtsio \
    && cp -r jtsio/lib/. solr-webapp/webapp/WEB-INF/lib \
    && rm -rf jts-1.14.zip ./jtsio

### /JTS Install

# Allows you to define the seed data in the docker-compose.data.yml file
# The seed zip file should contain the Solr server home directory that defines all of the core
#   definitions (similar to ./solr-home).
ARG SEED

# Copy over the seed data. This will not use cache if the zip file changes.
COPY $SEED /opt/solr/server/hadatac_solr.zip

# Unzips Solr seed data, copies its to the right place, then deletes the zip file
RUN unzip hadatac_solr.zip && cp -r hadatac_solr/. solr && rm -f hadatac_solr.zip

EXPOSE 8983

# Set solr-foreground as the final command. This is the default already.
CMD ["solr-foreground"]
