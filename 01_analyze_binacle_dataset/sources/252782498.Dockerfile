FROM jetbrains/teamcity-server:latest  
  
# Update everything  
RUN apt-get update  
  
# Install AWS CLI  
RUN apt-get -y install awscli mc  
  
# Add SSH public key  
COPY ./.ssh /root/.ssh  
  
# Copy setup script - run before teamcity server starts  
COPY ./claimer-ci-setup.sh /services/

