FROM node:6  
ENV ANGULAR_CLI_VERSION latest  
RUN wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo \  
&& dnf install yarn \  
&& yarn global add @angular/cli@${ANGULAR_CLI_VERSION}  

