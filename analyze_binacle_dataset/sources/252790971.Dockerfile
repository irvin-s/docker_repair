FROM node:6  
MAINTAINER CURSOR Education team support@cursor.education  
  
RUN apt-get update \  
&& apt-get install -y git  
  
RUN echo 2 && node -v  
  
ADD app/ /app/  
# RUN cd /app; npm install  
RUN npm rebuild node-sass --force  
  
RUN ls -la app  
  
ENV app /app  
WORKDIR ${app}  
  
EXPOSE 8080  
# CMD ["node", "/src/index.js"]  
# CMD ["bash"]  
CMD ["npm", "start"]  
# ENTRYPOINT ["/app/env/bin/uwsgi", "--ini", "/app/uwsgi.ini"]

