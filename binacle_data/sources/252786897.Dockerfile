FROM phusion/baseimage:latest  
MAINTAINER Br4zzor <br4zzor@protonmail.com>  
  
  
ENV REFRESHED_AT 2015-6-8  
# Update repositories, install git, gcc, make and supervisor and  
# clone down the latest OSSEC build from the official Github repo.  
RUN apt-get update && apt-get install -y git gcc make supervisor  
  
WORKDIR /tmp/  
  
RUN git clone https://github.com/ossec/ossec-hids.git  
  
# Copy the unattended installation config file from the build context  
# and put it where the OSSEC install script can find it. Then copy the  
# supervisord.conf file that let's ossec-control run as a foreground  
# process. Then run the install script, which will turn on just about  
# everything except e-mail notifications  
COPY preloaded-vars.conf /tmp/ossec-hids/etc/preloaded-vars.conf  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
RUN ./ossec-hids/install.sh  
  
# Clean-up by uninstalling git, gcc and make - since we won't need them  
# anymore. Then clean up the OSSEC install files  
RUN apt-get purge -y --auto-remove git gcc make  
RUN rm -rf /tmp/ossec-hids/  
  
# Set persistent volumes for the /etc and /log folders so that the logs  
# and agent keys survive a start/stop and expose ports for the  
# server/client ommunication (1514) and the syslog transport (514)  
ONBUILD VOLUME /var/ossec/etc  
ONBUILD VOLUME /var/ossec/logs  
  
EXPOSE 1514  
EXPOSE 514  
# Run supervisord so that the container will stay alive  
ENTRYPOINT ["/usr/bin/supervisord"]  

