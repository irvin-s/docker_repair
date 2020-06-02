FROM python:3.6.2  
MAINTAINER Benoit Moussaud (bmoussaud@xebialabs.com)  
  
RUN apt-get update && apt-get install -y curl zip  
  
# Create the group and user to be used in this container  
RUN groupadd flaskgroup && useradd -m -g flaskgroup -s /bin/bash flask  
  
# Create the working directory (and set it as the working directory)  
RUN mkdir -p /home/flask/app/web  
WORKDIR /home/flask/app/web  
  
RUN pip install flask  
  
EXPOSE 5000  
COPY app /home/flask/app/web/app/  
  
RUN chown -R flask:flaskgroup /home/flask  
USER flask  
  
#ALPINE RUN apk add --no-cache curl zip  
COPY xebialabs /xebialabs  
  
CMD [ "python", "app/app.py"]  
  

