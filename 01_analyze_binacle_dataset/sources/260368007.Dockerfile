FROM amirb/portal:nd

MAINTAINER Amir Barkal <amirb@webtech-inv.co.il>

ARG PROFILE_NAME=Dmgr01

ARG CELL_NAME=DefaultCell01

ARG NODE_NAME=DefaultNode01

ARG HOST_NAME=localhost

# Create Deployment Manager profile
RUN /opt/IBM/WebSphere/AppServer/bin/manageprofiles.sh -create -templatePath \
    /opt/IBM/WebSphere/AppServer/profileTemplates/management -profileName $PROFILE_NAME \
    -profilePath /opt/IBM/WebSphere/AppServer/profiles/$PROFILE_NAME  -serverType DEPLOYMENT_MANAGER \
    -cellName $CELL_NAME -nodeName $NODE_NAME -disableWASDesktopIntegration -hostName $HOST_NAME

EXPOSE 9060 9043 9809 8879 9632 9401 9403 9402 9100 7277 9352 5555 7060 11005 11006 9420

ENV PATH /opt/IBM/WebSphere/AppServer/bin:$PATH

RUN /opt/IBM/WebSphere/AppServer/bin/startManager.sh

COPY startDmgr.sh update*.py /work/

USER root

RUN chmod ugo+x /work/startDmgr.sh

USER was

CMD ["/work/startDmgr.sh"]
