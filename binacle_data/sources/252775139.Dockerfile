FROM beamstyle/aws_ecs-git  
MAINTAINER Thomas Cheng <thomas@beamstyle.com.hk>  
  
ENTRYPOINT ["sh", "-c"]  
  
# Running the custom script file "run.sh"  
ADD run.sh /usr/local/bin/  
RUN chmod +x /usr/local/bin/run.sh  
  
CMD ["/usr/local/bin/run.sh"]  

