FROM fabric8/java-centos-openjdk8-jre:1.0.0

MAINTAINER rhuss@redhat.com

EXPOSE 8181 8101

ENV KARAF_VERSION 3.0.4

RUN curl http://archive.apache.org/dist/karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz -o /tmp/karaf.tar.gz \
 && tar xzf /tmp/karaf.tar.gz -C /opt/ \
 && ln -s /opt/apache-karaf-${KARAF_VERSION} /opt/karaf \
 && rm /tmp/karaf.tar.gz

# Add roles
ADD users.properties /opt/apache-karaf-${KARAF_VERSION}/etc/

# Startup script
ADD deploy-and-run.sh /opt/karaf/bin/ 

RUN chmod a+x /opt/karaf/bin/deploy-and-run.sh \
 && rm -rf /opt/karaf/deploy/README  \
 && sed -i 's/^\(.*rootLogger.*\)out/\1stdout/' /opt/karaf/etc/org.ops4j.pax.logging.cfg

ENV PATH $PATH:/opt/karaf/bin

CMD /opt/karaf/bin/deploy-and-run.sh
