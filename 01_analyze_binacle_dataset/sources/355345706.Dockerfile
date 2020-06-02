FROM staci/base:0.1

# Add staci user and set password
RUN useradd -u 1000 -ms /bin/bash atlassian
RUN echo "atlassian:praqma" | chpasswd

ENV CROWD_VERSION 2.9.1
ENV CROWD_HOME /var/atlassian/crowd
ENV CROWD_INSTALL /opt/atlassian/crowd

# extract crowd
RUN  mkdir -p $CROWD_HOME \
  && chmod -R 700                 "${CROWD_HOME}" \
  && chown -R atlassian:atlassian "${CROWD_HOME}" \
  && mkdir -p $CROWD_INSTALL \
  && curl -o $CROWD_INSTALL/atlassian-crowd.tar.gz -SL "https://www.atlassian.com/software/crowd/downloads/binary/atlassian-crowd-$CROWD_VERSION.tar.gz" \
  && tar xf $CROWD_INSTALL/atlassian-crowd.tar.gz -C $CROWD_INSTALL --strip-components=1 \
  && echo "crowd.home=$CROWD_HOME" > $CROWD_INSTALL/crowd-webapp/WEB-INF/classes/crowd-init.properties \
  && rm -f $CROWD_INSTALL/atlassian-crowd.tar.gz \
  && chown -R atlassian:atlassian /opt/atlassian 

ENV Xms           512m
ENV Xmx           1024m

RUN sed -ri "s/-Xms128m/-Xms${Xms}/" $CROWD_INSTALL/apache-tomcat/bin/setenv.sh \
 && sed -ri "s/-Xmx512m/-Xmx${Xmx}/" $CROWD_INSTALL/apache-tomcat/bin/setenv.sh 

# Getting the MySQL driver
RUN curl -Ls "http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.36.tar.gz" | tar -xz --directory "${CROWD_INSTALL}/apache-tomcat/lib/" --strip-components=1 --no-same-owner

RUN chmod -R 700                 "${CROWD_INSTALL}" \
 && chown -R atlassian:atlassian "${CROWD_INSTALL}" 

# Use the user atlassian to run Jira.
USER atlassian:atlassian

VOLUME /var/atlassian/crowd

# Set the default working directory as the installation directory.
WORKDIR ${CROWD_HOME}

EXPOSE 8095
CMD ["/opt/atlassian/crowd/apache-tomcat/bin/catalina.sh", "run"]
