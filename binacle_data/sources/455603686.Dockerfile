# vim:set ft=dockerfile:
FROM mstr-custom-demo

COPY  *.sh ${DEMO_INSTALL_HOME}/

#8080 is tomcat for web client
#34952 is MSTR IServer port
EXPOSE 8080 34952
VOLUME /mnt/log

CMD ["${DEMO_INSTALL_HOME}/mstr_start.sh"]
