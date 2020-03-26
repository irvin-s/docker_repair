FROM openjdk:11.0.1-jdk

RUN apt-get update \
  && apt-get install -y \
     unzip \
     python-dateutil \
     jq \
     curl \
     gcc \
     python-dev \
     python-setuptools

RUN python /usr/lib/python2.7/dist-packages/easy_install.py --quiet -U pip \
  && pip install -U crcmod

RUN mkdir -p /code/otpdata/norway

WORKDIR /code

# From https://cloud.google.com/sdk/downloads
RUN wget -nv https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-226.0.0-linux-x86_64.tar.gz \
     && echo "1ca10545778f50a8435f3002618ca19b8fbb145bbc550f36fcd0fdb9773466e5 google-cloud-sdk-226.0.0-linux-x86_64.tar.gz" | sha256sum --quiet -c - \
     && tar xzf google-cloud-sdk-226.0.0-linux-x86_64.tar.gz

# Download logback logstash
RUN wget -nv "http://central.maven.org/maven2/net/logstash/logback/logstash-logback-encoder/4.7/logstash-logback-encoder-4.7.jar" --directory-prefix /code/

# Copy OTP jar file from target
COPY target/otp-*-shaded.jar /code/otp-shaded.jar

# Copy the logback xml file
COPY docker/logback.xml /code/logback.xml

RUN jar xf /code/logstash-logback-encoder-4.7.jar \
 && jar -uf /code/otp-shaded.jar logback.xml net/

RUN mkdir -p /opt/agent-bond \
  && curl http://central.maven.org/maven2/io/fabric8/agent-bond-agent/1.0.2/agent-bond-agent-1.0.2.jar \
         -o /opt/agent-bond/agent-bond.jar \
 && chmod 444 /opt/agent-bond/agent-bond.jar
ADD docker/jmx_exporter_config.yml /opt/agent-bond/

COPY docker/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod a+x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8080
CMD ["java", "-Dtransmodel.graphql.api.agency.id=RB","-Dfile.encoding=UTF-8", "-Xms256m", "-Xmx6144m", "-server", "-javaagent:/opt/agent-bond/agent-bond.jar=jolokia{{'{{' }}host=0.0.0.0{{ '}}' }},jmx_exporter{{ '{{' }}9779:/opt/agent-bond/jmx_exporter_config.yml{{ '}}' }}", "-jar", "code/otp-shaded.jar", "--server", "--graphs","/code/otpdata", "--router", "norway"]

# For debug, add parameter "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005"
