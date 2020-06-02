FROM codeception/codeception  
  
WORKDIR /repo  
  
RUN composer require neronmoon/teamcity-codeception  
  
ENV CI=CI

