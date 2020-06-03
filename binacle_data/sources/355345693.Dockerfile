FROM staci/base:0.1

ENV BAMBOO_HOME=/var/lib/bamboo \
    BAMBOO_INSTALL=/opt/atlassian/bamboo \
    BAMBOO_UID=1000 \
    BAMBOO_USER=atlassian \
    BAMBOO_GID=1000 \
    BAMBOO_GROUP=atlassian \
    BAMBOO_VERSION=5.12.3.1 

ENV DEBIAN_FRONTEND=noninteractive 

### Install tools used by Bamboo like git
RUN apt-get install git -y

### Let the JVM find the Tomcat Native and APR shared objects
RUN ln -sv /usr/lib/x86_64-linux-gnu /usr/lib64 

### Install Bamboo
RUN mkdir -p ${BAMBOO_INSTALL} ${BAMBOO_HOME} \
 && groupadd -g ${BAMBOO_GID} ${BAMBOO_GROUP} \
 && useradd -d ${BAMBOO_INSTALL} -u ${BAMBOO_UID} -g ${BAMBOO_GID} -c "Atlassian Bamboo" ${BAMBOO_USER} \
 && wget --progress=dot:mega -O- "https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${BAMBOO_VERSION}.tar.gz" | tar -xz --strip=1 -C "${BAMBOO_INSTALL}" \
 && echo "bamboo.home=${BAMBOO_HOME}" > ${BAMBOO_INSTALL}/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties \
 && chmod -R 700 ${BAMBOO_INSTALL} ${BAMBOO_HOME} \
 && chown -R ${BAMBOO_USER}:${BAMBOO_GROUP} \
        ${BAMBOO_HOME} \
        ${BAMBOO_INSTALL} \
        /etc/ssl \
 && find ${BAMBOO_INSTALL} -name "*.sh" | xargs chmod -v +x 

### Cleanup
RUN apt-get clean \
 && rm -rf \
        /etc/java-6-sun \
        /tmp/* \
        /var/tmp/* \
        /var/cache/oracle-* \
        /var/lib/apt/lists/*


# Getting the MySQL driver
RUN curl -Ls "http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.36.tar.gz" | tar -xz --directory "${BAMBOO_INSTALL}/lib/" --strip-components=1 --no-same-owner

# Fix Issue #2  -- https://github.com/Praqma/staci/issues/2
COPY setContextPath.sh /tmp/setContextPath.sh
RUN /tmp/setContextPath.sh

USER ${BAMBOO_USER}:${BAMBOO_GROUP}

COPY src/main/container/srv/ /srv/

VOLUME ["${BAMBOO_HOME}"]

#      HTTP MASTER
EXPOSE 8085 54663

# Fix Issue #1  -- https://github.com/Praqma/staci/issues/1
RUN sed -i -e 's/<Context>/<Context sessionCookieName="BAMBOOSESSIONID">/g' /opt/atlassian/bamboo/conf/context.xml

WORKDIR ${BAMBOO_INSTALL}

ENTRYPOINT ["/srv/bamboo.sh"]
CMD ["server"]
