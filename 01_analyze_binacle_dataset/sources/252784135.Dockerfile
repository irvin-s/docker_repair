#################################################################  
# Dockerfile  
#  
# Software: MEA  
# Software Version: 1.0 (commit c33981de99dfd20f76fd5cd904e2f630eef0f4ae)  
# Description: Methylomic and Epigenomic Allele-specific analysis pipeline  
# Website: https://github.com/julienrichardalbert/MEA  
# Provides: alea.jar  
# Base Image: biowardrobe2/mea:v0.0.1  
# Build Cmd: docker build --rm -t biowardrobe2/mea:v0.0.1 -f mea-Dockerfile .  
# Pull Cmd: docker pull biowardrobe2/mea:v0.0.1  
# Run Cmd: docker run --rm -ti biowardrobe2/mea:v0.0.1 /bin/bash  
#################################################################  
  
### Base Image  
FROM biowardrobe2/scidap:v0.0.3  
MAINTAINER Michael Kotliar "misha.kotliar@gmail.com"  
ENV DEBIAN_FRONTEND noninteractive  
  
################## BEGIN INSTALLATION ######################  
  
WORKDIR /tmp  
  
  
ENV VERSION_MEA_COMMIT c33981de99dfd20f76fd5cd904e2f630eef0f4ae  
ENV URL_MEA "https://github.com/julienrichardalbert/MEA.git"  
  
  
### Installing MEA  
  
RUN git clone ${URL_MEA} &&\  
cd MEA &&\  
git checkout ${VERSION_MEA_COMMIT} &&\  
tar xzf ./dist/mea.1.0.tar.gz &&\  
cp mea/bin/* /usr/local/bin/ &&\  
rm -rf /tmp/*

