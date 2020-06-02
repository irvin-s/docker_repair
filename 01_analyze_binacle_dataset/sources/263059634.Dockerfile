# jenkins/jenkins is official repo
# jenkins:lts is debian based 800mb, jenkins:lts-alpine is 200mb.
FROM jenkins/jenkins:2.164.2-alpine

ARG UCPURL="https://ucp.olly.dtcntr.net:8443"

# Embed UCP CA Certificate in Container Base Image and into Java
USER root
RUN (curl -sk ${UCPURL}/ca > /usr/local/share/ca-certificates/ucp.crt && \
    update-ca-certificates && \
    cp /usr/local/share/ca-certificates/ucp.crt $JAVA_HOME/jre/lib/security/ucp.crt && \
    cd $JAVA_HOME/jre/lib/security && \
    keytool -keystore cacerts -storepass changeit -noprompt -trustcacerts -importcert -alias ucpcert -file ucp.crt && \
    rm -rf /home/jenkins)

# Switch back to Jenkins User before running the container
USER jenkins
