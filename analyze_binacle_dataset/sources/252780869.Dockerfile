FROM java:8-jre  
MAINTAINER Alexander Gorokhov <sashgorokhov@gmail.com>  
  
RUN apt-get update && apt-get install -y --no-install-recommends unzip git \  
# Clean up packages  
&& apt-get autoclean \  
&& apt-get clean \  
&& apt-get autoremove -y \  
# Remove extraneous files  
&& rm -rf /var/lib/apt/lists/* \  
&& rm -rf /var/tmp/* \  
&& rm -rf /usr/share/man/* \  
&& rm -rf /usr/share/info/* \  
&& rm -rf /var/cache/man/* \  
&& rm -rf /tmp/*  
  
ENV SERVER_URL="" \  
AGENT_OWN_ADDRESS="" \  
AGENT_OWN_PORT="9090" \  
AGENT_NAME="" \  
AGENT_DIR="/opt/teamcity_agent"  
ENV AGENT_WORKDIR=$AGENT_DIR"/work_dir" \  
AGENT_TEMPDIR=$AGENT_DIR"/temp_dir"  
EXPOSE $AGENT_OWN_PORT  
VOLUME $AGENT_WORKDIR $AGENT_TEMPDIR  
WORKDIR $AGENT_DIR  
  
RUN mkdir /agent-init.d  
COPY /setup_docker.sh /agent-init.d/  
  
COPY setup_agent.sh /  
CMD /setup_agent.sh && $AGENT_DIR/bin/agent.sh run  

