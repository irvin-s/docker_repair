# start from base  
FROM python:3-onbuild  
MAINTAINER aminami1127  
  
# copy our application code  
ADD dailymagiceye /opt/dailymagiceye  
WORKDIR /opt/dailymagiceye  
  
# expose port  
EXPOSE 5000  
# start app  
CMD ["python", "-m", "http.server", "5000"]  

