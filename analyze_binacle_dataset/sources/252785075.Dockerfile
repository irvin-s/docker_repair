FROM node:8  
ADD image /project/target  
  
RUN chmod +x /project/target/run.sh  
RUN chmod +x /project/target/validate.sh  
RUN cd /project/target \  
&& npm install  
  

