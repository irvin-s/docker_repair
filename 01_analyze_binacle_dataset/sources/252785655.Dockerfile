FROM ubuntu:16.04  
RUN apt-get update && apt-get -y upgrade  
  
RUN apt-get install default-jdk git ruby wget unzip -y  
  
# Define default command.  
CMD ["bash"]  
  
# Install the Android SDK  
# https://github.com/Commit451/android-sdk-installer  
RUN gem install android-sdk-installer -v 1.1.1  
RUN android-sdk-installer  
ENV ANDROID_HOME=$PWD/android-sdk  

