FROM auroq/steamcmd:1.0  
LABEL maintainer Parker Johansen <johansen.parker@gmail.com>  
  
ARG steamdir=/steamcmd  
ARG gamedir=$steamdir/7daystodie  
  
RUN $steamdir/steamcmd.sh \  
+login anonymous \  
+force_install_dir $gamedir \  
+app_update 294420 \  
+quit && \  
mv $gamedir/serverconfig.xml $gamedir/serverconfig-template.xml  
  
COPY start7daystodie.sh startserver.sh serverconfig.py $gamedir/  
  
RUN chmod +x $gamedir/start7daystodie.sh && \  
chmod +x $gamedir/startserver.sh  
  
VOLUME $gamedir/logs $gamedir/config $gamedir/saves  
  
EXPOSE 26900 8080  
ENV gamedirectory=$gamedir  
ENV password=""  
ENV controlpassword=""  
CMD $gamedirectory/start7daystodie.sh $password $controlpassword  

