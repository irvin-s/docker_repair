FROM binocarlos/yarn-base  
MAINTAINER kaiyadavenport@gmail.com  
RUN yarn global add khaos  
ADD ./run.sh /run.sh  
ADD scaffold/templates /templates  
ENTRYPOINT ["bash", "/run.sh"]

