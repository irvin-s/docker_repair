FROM devanlai/diptrace:stable  
  
MAINTAINER Devan Lai <devan.lai@gmail.com>  
  
RUN apt-get -y update && apt-get install -y zip  
  
COPY bin/* /tmp/bin/  
  
COPY diptrace.reg /tmp/diptrace.reg  
RUN xvfb-run wine regedit /tmp/diptrace.reg && \  
/tmp/bin/waitfor.sh wineserver  
  
RUN rm /tmp/diptrace.reg  
  
COPY ahk/*.ahk /tmp/ahk/  
  
ENTRYPOINT ["/tmp/bin/export-bitmap.sh"]  

