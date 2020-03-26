FROM digitalagendadata/scoreboard.plone:latest  
  
# needed for egg builds  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends git gcc libffi-dev libc6-dev  
  
# User change needed because /usr/local/bin/{python2.7,pip,buildout}  
# are symlinked into ./bin and the setpermissions part in base.cfg  
# results in breaking the +x permission for everybody except root  
USER plone  
COPY staging.cfg /plone/instance/  
  
RUN rm -rf /plone/instance/src/scoreboard.theme \  
/plone/instance/src/scoreboard.visualization \  
/plone/instance/src/edw.datacube \  
&& buildout -c staging.cfg  
  
# cleanup  
USER root  
RUN apt-get purge -y --auto-remove gcc libffi-dev libc6-dev \  
&& rm -rf /var/lib/apt/lists/* \  
&& rm -rf /plone/buildout-cache/downloads/*  
  

