FROM debian:jessie  
MAINTAINER Thomas Cheng <thomas@beamstyle.com.hk>  
  
# Installing Git  
RUN apt-get update  
RUN apt-get install -y \  
git  
  
ENTRYPOINT ["sh", "-c"]  
  
# Running the custom script file "run.sh"  
ADD run.sh /usr/local/bin/  
RUN chmod +x /usr/local/bin/run.sh  
  
CMD ["/usr/local/bin/run.sh"]

