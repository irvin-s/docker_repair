FROM zenoss/gulp  
  
RUN npm install -g gulp-sass  
  
ENTRYPOINT ["/root/kickoff.sh"]

