FROM ubuntu:14.04

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN apt-get -qq update && \
    apt-get install --no-install-recommends -y locales wget && \
    echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    apt-get install --no-install-recommends -y maven make openjdk-7-jdk && \
    apt-get autoremove -y  && \
    apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://github.com/jwilder/dockerize/releases/download/v0.2.0/dockerize-linux-amd64-v0.2.0.tar.gz && \
    tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.2.0.tar.gz

RUN wget https://github.com/AKSW/Sparqlify/archive/sparqlify-parent-0.6.20.tar.gz -O /sparqlify.tar.gz && \
    tar xvfz /sparqlify.tar.gz
RUN cd Sparqlify-sparqlify-parent-0.6.20 && mvn clean install
RUN cd /Sparqlify-sparqlify-parent-0.6.20/sparqlify-cli && mvn assembly:assembly


ADD startup.tmpl /

ENV MAX_RESULT_SET_SIZE=10000 \
    MAX_QUERY_EXEC_TIME=10

EXPOSE 7531
CMD dockerize -template /startup.tmpl:/startup.sh bash /startup.sh
