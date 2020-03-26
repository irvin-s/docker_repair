FROM docker.elastic.co/elasticsearch/elasticsearch:5.6.5

# Install the AWS plugin
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install discovery-ec2
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install repository-s3
