FROM bconnect/gitlab-base  
  
ENV WEB_HOOK_URL https://notify.b-connect.eu  
ENV NOTIFICATION_TOKEN notify  
ENV MESSAGE_TEMPLATE ''  
ENV GITLAB_PROJECT_NAME 'project'  
ADD runner.sh /runner.sh  
ADD success.sh /success.sh  
ADD error.sh /error.sh  
ADD pre-load.sh /pre-load.sh  
  
RUN chmod +x /runner.sh  
RUN chmod +x /error.sh  
RUN chmod +x /success.sh  

