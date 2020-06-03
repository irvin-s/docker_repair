# vim:set ft=dockerfile:
FROM mstr-pre-demo

COPY  *.jar ${DEMO_INSTALL_HOME}/
COPY  *.sh  ${DEMO_INSTALL_HOME}/
# COPY  password.txt ${DEMO_INSTALL_HOME}/
COPY  fonts/*  ${DEMO_INSTALL_HOME}/fonts/
COPY  img/*  ${DEMO_INSTALL_HOME}/img/

#Have to specify some entrypoint to reset one from parent image
#ENTRYPOINT []
ENTRYPOINT ["/bin/bash","-c"]
#CMD bash -c '${DEMO_INSTALL_HOME}/mstr_init.sh';'bash'
