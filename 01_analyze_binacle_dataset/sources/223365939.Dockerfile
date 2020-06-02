# sudo docker build -t dreamlab/goffish3-hama-bin .


FROM dreamlab/goffish3-hama-base
MAINTAINER dreamlab

USER root


ADD goffish_jar/goffish-hama-3.1.jar  $HAMA_HOME/lib/
ADD goffish_jar/goffish-sample-3.1.jar  $HAMA_HOME/lib/
ADD goffish_jar/goffish-api-3.1.jar  $HAMA_HOME/lib/
ADD goffish_jar/fastutil-7.0.9.jar  $HAMA_HOME/lib/

RUN mkdir $HAMA_HOME/properties
ADD properties/ConnectedComponents.properties  $HAMA_HOME/properties/
ADD properties/EdgeList.properties  $HAMA_HOME/properties/
ADD properties/GraphStats.properties  $HAMA_HOME/properties/
ADD properties/MetaGraph.properties  $HAMA_HOME/properties/
ADD properties/PageRank.properties  $HAMA_HOME/properties/
ADD properties/SSSP.properties  $HAMA_HOME/properties/
ADD properties/TriangleCount.properties  $HAMA_HOME/properties/
ADD properties/VertexCount.properties  $HAMA_HOME/properties/



ADD bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh && \
    chmod 700 /etc/bootstrap.sh

ENV BOOTSTRAP /etc/bootstrap.sh



#GOFFISH COMMAND

ADD goffish /bin
RUN chmod +x /bin/goffish


CMD ["/etc/bootstrap.sh", "-d"]

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 19888 8030 8031 8032 8033 8040 8042 8088 49707 2122
# Mapred ports
#EXPOSE 19888
#Yarn ports
#EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
#EXPOSE 49707 2122   

