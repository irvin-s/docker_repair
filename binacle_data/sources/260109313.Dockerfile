FROM playniuniu/weblogic-base:12.2.1.2
LABEL maintainer="playniuniu@gmail.com"

# WLS Configuration (editable during build time)
# ------------------------------
ARG ADMIN_PASSWORD
ARG ADMIN_PORT
ARG CLUSTER_NAME
ARG PRODUCTION_MODE

# WLS Configuration (persisted. do not change during runtime)
# -----------------------------------------------------------
ENV DOMAIN_NAME="${DOMAIN_NAME:-base_domain}" \
    DOMAIN_HOME=/home/oracle/domains/${DOMAIN_NAME:-base_domain} \
    ADMIN_HOST="wlsadmin" \
    ADMIN_PORT="${ADMIN_PORT:-8001}" \
    ADMIN_PASSWORD="${ADMIN_PASSWORD:-welcome1}" \
    MS_PORT="7001" \
    CLUSTER_NAME="${CLUSTER_NAME:-DockerCluster}" \
    PRODUCTION_MODE="${PRODUCTION_MODE:-prod}" \
    CONFIG_JVM_ARGS="-Dweblogic.security.SSL.ignoreHostnameVerification=true" \
    PATH=$PATH:/home/oracle/domains/${DOMAIN_NAME:-base_domain}/bin

COPY scripts/* /home/oracle/bin/

# Configuration of WLS Domain
RUN wlst.sh -skipWLSModuleScanning /home/oracle/bin/create-domain.py \
    && mkdir -p ${DOMAIN_HOME}/servers/AdminServer/security/ \
    && echo "username=weblogic" > ${DOMAIN_HOME}/servers/AdminServer/security/boot.properties \
    && echo "password=${ADMIN_PASSWORD}" >> ${DOMAIN_HOME}/servers/AdminServer/security/boot.properties \
    && sed -i -e 's/^WLS_USER=.*/WLS_USER=\"weblogic\"/' ${DOMAIN_HOME}/bin/startManagedWebLogic.sh \
    && sed -i -e 's/^WLS_PW=.*/WLS_PW=\"${ADMIN_PASSWORD}\"/' ${DOMAIN_HOME}/bin/startManagedWebLogic.sh \
    && echo "source ${DOMAIN_HOME}/bin/setDomainEnv.sh" >> /home/oracle/.bashrc

# Expose Node Manager default port, and also default for admin and managed server 
EXPOSE ${ADMIN_PORT} ${MS_PORT}

# Define default command to start bash. 
CMD ["startWebLogic.sh"]
