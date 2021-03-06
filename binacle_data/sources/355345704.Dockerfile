FROM staci/base:0.1

# Setup useful environment variables
ENV CONF_HOME     /var/atlassian/confluence
ENV CONF_INSTALL  /opt/atlassian/confluence
ENV CONF_VERSION  5.10.4

# Define memory usage for tomcat
ENV Xms		  512m
ENV Xmx		  2048m

# Add luci user and set password
RUN useradd -u 1000 -ms /bin/bash atlassian
RUN echo "atlassian:praqma" | chpasswd

# Install Atlassian Confluence and helper tools and setup initial home
# directory structure.
RUN set -x \
    && mkdir -p                "${CONF_HOME}" \
    && chmod -R 700            "${CONF_HOME}" \
    && chown atlassian:atlassian     "${CONF_HOME}" \
    && mkdir -p                "${CONF_INSTALL}/conf" \
    && curl -Ls                "http://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-${CONF_VERSION}.tar.gz" | tar -xz --directory "${CONF_INSTALL}" --strip-components=1 --no-same-owner \
    && chmod -R 700            "${CONF_INSTALL}/conf" \
    && chmod -R 700            "${CONF_INSTALL}/temp" \
    && chmod -R 700            "${CONF_INSTALL}/logs" \
    && chmod -R 700            "${CONF_INSTALL}/work" \
    && chown -R atlassian:atlassian  "${CONF_INSTALL}/conf" \
    && chown -R atlassian:atlassian  "${CONF_INSTALL}/temp" \
    && chown -R atlassian:atlassian  "${CONF_INSTALL}/logs" \
    && chown -R atlassian:atlassian  "${CONF_INSTALL}/work" \
    && echo -e                 "\nconfluence.home=$CONF_HOME" >> "${CONF_INSTALL}/confluence/WEB-INF/classes/confluence-init.properties" \
    && xmlstarlet              ed --inplace \
        --delete               "Server/@debug" \
        --delete               "Server/Service/Connector/@debug" \
        --delete               "Server/Service/Connector/@useURIValidationHack" \
        --delete               "Server/Service/Connector/@minProcessors" \
        --delete               "Server/Service/Connector/@maxProcessors" \
        --delete               "Server/Service/Engine/@debug" \
        --delete               "Server/Service/Engine/Host/@debug" \
        --delete               "Server/Service/Engine/Host/Context/@debug" \
                               "${CONF_INSTALL}/conf/server.xml" \
    && sed -ri "s/-Xms1024m -Xmx1024m/-Xms${Xms} -Xmx${Xmx}/" $CONF_INSTALL/bin/setenv.sh

# Getting the MySQL driver
RUN curl -Ls "http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.36.tar.gz" | tar -xz --directory "${CONF_INSTALL}/confluence/WEB-INF/lib/" --strip-components=1 --no-same-owner

# Fix Issue #2  -- https://github.com/Praqma/staci/issues/2
COPY setContextPath.sh /tmp/setContextPath.sh
RUN /tmp/setContextPath.sh

# Use the default unprivileged account. This could be considered bad practice
# on systems where multiple processes end up being executed by 'daemon' but
# here we only ever run one process anyway.
USER atlassian:atlassian

# Expose default HTTP connector port.
EXPOSE 8090

# Set volume mount points for installation and home directory. Changes to the
# home directory needs to be persisted as well as parts of the installation
# directory due to eg. logs.
VOLUME ["/var/atlassian/confluence"]

# Fix Issue #1  -- https://github.com/Praqma/staci/issues/1
RUN sed -i -e 's/<Context>/<Context sessionCookieName="CONFLUENCESESSIONID">/g' /opt/atlassian/confluence/conf/context.xml

# Set the default working directory as the Confluence home directory.
WORKDIR ${CONF_HOME}

# Run Atlassian Confluence as a foreground process by default.
CMD ["/opt/atlassian/confluence/bin/start-confluence.sh", "-fg"]
