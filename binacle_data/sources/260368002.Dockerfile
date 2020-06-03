FROM amirb/portal:nd

MAINTAINER Amir Barkal <amirb@webtech-inv.co.il>

ARG PROFILE_NAME=custom

ARG CELL_NAME=CustomCell

ARG NODE_NAME=CustomNode

ARG HOST_NAME=localhost

# Create default Custom Node profile
RUN /opt/IBM/WebSphere/AppServer/bin/manageprofiles.sh -create -templatePath \
    /opt/IBM/WebSphere/AppServer/profileTemplates/managed -profileName $PROFILE_NAME \
    -profilePath /opt/IBM/WebSphere/AppServer/profiles/$PROFILE_NAME -cellName $CELL_NAME \
    -nodeName $NODE_NAME -disableWASDesktopIntegration -FederateLater true -hostName $HOST_NAME

#Expose the ports 
EXPOSE 2809 9402 9403 9353 9633 9100 11004 11003 9401 7276 7286 5558 5578 5060 5061 8880 9060 9043 9080 9443

ENV PATH /opt/IBM/WebSphere/AppServer/bin:$PATH

COPY *.sh *.py /work/

USER root

RUN chmod ugo+x /work/*.sh

USER was

CMD ["/work/updateHostAndAddNode.sh"]
