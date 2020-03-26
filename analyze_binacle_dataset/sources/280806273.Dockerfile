FROM resin/rpi-raspbian:latest

RUN echo 'deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti' | sudo tee -a /etc/apt/sources.list.d/ubnt.list > /dev/null && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
    apt-get update && \
    apt-get install wget apt-utils unifi -y && \
    echo 'ENABLE_MONGODB=no' | sudo tee -a /etc/mongodb.conf > /dev/null
    
RUN wget http://central.maven.org/maven2/org/xerial/snappy/snappy-java/1.1.4-M3/snappy-java-1.1.4-M3.jar && \
    mv snappy-java-1.1.4-M3.jar /usr/lib/unifi/lib/snappy-*

RUN ln -s /data /usr/lib/unifi/data && \
    mkdir -p /data/logs && \
    touch /data/logs/server.log && \
    ln -sf /dev/stdout /data/logs/server.log

WORKDIR /data

ENTRYPOINT ["/usr/bin/java", "-Xmx256M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]

EXPOSE 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp 3478/udp
