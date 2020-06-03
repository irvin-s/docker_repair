FROM ubuntu:12.04  
  
MAINTAINER @cohesivenet  
  
# This copyrighted material is the property of  
# Cohesive Networks and is subject to the license  
# terms of the product it is contained within, whether in text  
# or compiled form. It is licensed under the terms expressed  
# in the accompanying README.md and LICENSE.md files.  
#  
# This program is AS IS and WITHOUT ANY WARRANTY; without even  
# the implied warranty of MERCHANTABILITY or  
# FITNESS FOR A PARTICULAR PURPOSE.  
# Single RUN command to avoid wasted layers  
RUN export DEBIAN_FRONTEND=noninteractive &&\  
apt-get update &&\  
apt-get install -y wget sudo ruby rubygems &&\  
gem install --no-rdoc --no-ri json &&\  
useradd -m vns3api &&\  
wget --no-check-certificate \  
https://cohesive.net/dnld/VNS3_35_API_TOOL_20140627.tar.gz &&\  
tar -xvf /VNS3_35_API_TOOL_20140627.tar.gz -C /home/vns3api/ &&\  
rm /VNS3_35_API_TOOL_20140627.tar.gz &&\  
chmod +x /home/vns3api/vnscubed.rb  
  
CMD /usr/bin/sudo -iu vns3api /bin/bash  
  
# Example runline:  
# sudo docker run -it cohesivenet/vns3api  

