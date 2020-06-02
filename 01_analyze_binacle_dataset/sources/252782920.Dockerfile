FROM node:6  
  
# Upgrade yarn  
RUN npm install --global yarn@1.3.2  
  
# Add ruby and cocoapods  
RUN apt-get update  
RUN apt-get install -y ruby-full  
  
# Packaged `activesupport` incompatible  
# with packaged `ruby` version  
RUN gem install activesupport -v 4.2.6  
  
RUN gem install cocoapods  
  
# You cannot run CocoaPods as root  
# (user `nobody` does not have enough permissions)  
USER node  
RUN pod setup  
  
# Restore default user back to `root`  
USER root  

