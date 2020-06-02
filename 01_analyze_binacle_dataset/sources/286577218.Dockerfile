FROM cptactionhank/atlassian-jira-software:7.5.0

COPY atlassian-universal-plugin-manager-plugin-2.22.5.jar ${JIRA_INSTALL}/atlassian-jira/WEB-INF/atlassian-bundled-plugins/atlassian-universal-plugin-manager-plugin-2.22.5.jar
COPY atlassian-extras-3.2.jar ${JIRA_INSTALL}/atlassian-jira/WEB-INF/lib/atlassian-extras-3.2.jar

CMD ["/opt/atlassian/jira/bin/catalina.sh", "run"]
