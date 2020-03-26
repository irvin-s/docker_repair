FROM node:argon  
  
ADD ./entry.sh /entry.sh  
RUN chmod a+x /entry.sh  
  
EXPOSE 80  
CMD "/entry.sh"  

