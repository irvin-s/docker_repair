# Elasticsearch Curator  
FROM digitalwonderland/base  
  
RUN yum install -y epel-release \  
&& yum install -y python-pip python-argparse \  
&& yum clean all \  
&& pip install elasticsearch-curator  
  
USER nobody  
  
ENTRYPOINT ["/usr/bin/curator"]  
  
CMD ["--help"]  

