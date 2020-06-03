FROM cptactionhank/atlassian-confluence:6.3.4

COPY atlassian-extras-decoder-v2-3.2.jar ${CONF_INSTALL}/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.2.jar
COPY atlassian-universal-plugin-manager-plugin-2.22.5.jar ${CONF_INSTALL}/confluence/WEB-INF/atlassian-bundled-plugins/atlassian-universal-plugin-manager-plugin-2.22.5.jar
COPY setenv.sh ${CONF_INSTALL}/bin/setenv.sh

CMD ["/opt/atlassian/confluence/bin/start-confluence.sh", "-fg"]
