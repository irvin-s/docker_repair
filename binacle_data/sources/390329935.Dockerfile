# the official solr image starts at 5.3. makuk66/docker-solr is similar and can allow us to use the same
# version as is used in production. However, makuk66/docker-solr only comes with a single core: colleciton1
# and it doesn't seem possible to add more.

# FROM makuk66/docker-solr:4.10.4
FROM solr:5.3

# spatial search library for solr
ADD ./solr/jts-1.13.jar /opt/solr/server/lib/jts-1.13.jar
