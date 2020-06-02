FROM mongooseim/mongooseim-docker  
MAINTAINER Appertise <appertise.co@gmail.com>  
  
ENV EJABBERD_API_AUTH_TOKEN $EJABBERD_API_AUTH_TOKEN  
ENV EJABBERD_DOMAIN $EJABBERD_DOMAIN  
ENV EJABBERD_API_CONTEXT_PATH $EJABBERD_API_CONTEXT_PATH  
  
## add the module to the source directory  
ADD ./mod_push.erl /opt/mongooseim/apps/ejabberd/src/  
ADD ./mod_user_status.erl /opt/mongooseim/apps/ejabberd/src/  
  
RUN cd /opt/mongooseim && make rel  
  
ADD ejabberd.cfg /opt/mongooseim/rel/mongooseim/etc/ejabberd.cfg  
  
ADD ./start-mongoose.sh ./start-mongoose.sh  
RUN chmod +x ./start-mongoose.sh  
  
ENTRYPOINT ["./start-mongoose.sh"]  

