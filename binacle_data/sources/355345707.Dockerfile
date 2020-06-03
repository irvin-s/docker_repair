#FROM java:8
FROM staci/base:0.1

# Add staci user and set password
RUN useradd -u 1000 -ms /bin/bash atlassian
RUN echo "atlassian:praqma" | chpasswd

# Install tools
RUN apt-get update && \
  apt-get install -y git mercurial subversion && \
  wget -P /usr/bin http://www.perforce.com/downloads/perforce/r15.1/bin.linux26x86_64/p4 && \
  chmod +x /usr/bin/p4

# Configuration variables.
ENV LANG C.UTF-8
ENV FECRU_VERSION 4.2.0
ENV FISHEYE_HOME /var/atlassian/crucible
ENV FISHEYE_INST /opt/atlassian/crucible

# Set Fisheye memory usage
# ENV FISHEYE_OPTS -Xmx3072m -XX:MaxPermSize=256m

WORKDIR /opt/atlassian/

# download and install fisheye to /opt/atlassian/fisheye
RUN wget -q "http://www.atlassian.com/software/crucible/downloads/binary/crucible-${FECRU_VERSION}.zip" -O crucible-${FECRU_VERSION}.zip \
&& unzip -q crucible-${FECRU_VERSION}.zip \
&& mv fecru-${FECRU_VERSION} crucible \
&& mkdir -p ${FISHEYE_HOME}/crucible 

# Getting the MySQL driver
RUN curl -Ls "http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.36.tar.gz" | tar -xz --directory "${FISHEYE_INST}/lib/" --strip-components=1 --no-same-owner

ADD start.sh ${FISHEYE_INST}/
RUN chmod +x ${FISHEYE_INST}/start.sh
ADD configure.sh ${FISHEYE_INST}/
RUN chmod +x ${FISHEYE_INST}/configure.sh

RUN chmod -R 700                 "${FISHEYE_INST}" \
&&  chmod -R 700                 "${FISHEYE_HOME}" \
&&  chown -R atlassian:atlassian "${FISHEYE_INST}" \
&&  chown -R atlassian:atlassian "${FISHEYE_HOME}" 

# Use the user atlassian to run Jira.
USER atlassian:atlassian

VOLUME ${FISHEYE_HOME} 

EXPOSE 8060

WORKDIR ${FISHEYE_INST}/
RUN ./configure.sh

CMD ["./bin/run.sh"]
