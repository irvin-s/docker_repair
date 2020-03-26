FROM circleci/android:api-27-alpha  
  
RUN sudo apt-get update \  
&& sudo apt-get install -y \  
awscli  
  
COPY tools/* /tools/  

