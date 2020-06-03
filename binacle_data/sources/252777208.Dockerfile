FROM debian:jessie  
  
ENV JIRA_VERSION="7.1.2" \  
JIRA_HTTP_PORT=8080 \  
JIRA_RMI_PORT=8005 \  
JIRA_HOME="/var/atlassian/application-data/jira/" \  
JIRA_INSTALL="/opt/atlassian/jira" \  
JIRA_BASE_FILE="atlassian-jira-software" \  
JIRA_BASE_URL="http://www.atlassian.com/software/jira/downloads/binary" \  
CONNECTOR_BASE_URL="https://dev.mysql.com/get/Downloads/Connector-J" \  
CONNECTOR="mysql-connector-java-5.1.38"  
  
ENV JIRA_FILE="${JIRA_BASE_FILE}-${JIRA_VERSION}-jira-${JIRA_VERSION}-x64.bin"  
ADD response.varfile response.varfile  
  
RUN set -x \  
&& apt-get update -q \  
&& apt-get install -q -y wget \  
&& apt-get clean \  
&& wget -q "${JIRA_BASE_URL}/${JIRA_FILE}" \  
&& wget -q "${CONNECTOR_BASE_URL}/${CONNECTOR}.tar.gz" \  
&& chmod 700 "${JIRA_FILE}" \  
&& "./${JIRA_FILE}" -q -varfile response.varfile \  
&& tar -xf "${CONNECTOR}.tar.gz" \  
&& mv "./${CONNECTOR}/${CONNECTOR}-bin.jar" "${JIRA_INSTALL}/lib" \  
&& rm "${JIRA_FILE}" \  
&& rm -r "${CONNECTOR}"  
  
EXPOSE ${JIRA_HTTP_PORT} ${JIRA_RMI_PORT}  
  
VOLUME "${JIRA_HOME}"  
WORKDIR "${JIRA_INSTALL}/bin"  
  
ENTRYPOINT ["./start-jira.sh", "-fg"]  

