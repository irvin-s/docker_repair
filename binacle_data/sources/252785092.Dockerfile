FROM codingame/scala-sbt:2.12  
COPY build.sh /project/build  
COPY entrypoint.sh /  
  
RUN chmod +x /project/build entrypoint.sh  
  
# Configure where the user's answer will be copied  
ENV CG_RUN_DIR /project/answer  
  
ENTRYPOINT ["/entrypoint.sh"]  

