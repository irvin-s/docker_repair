FROM ubuntu:14.04  
#test  
#test  
MAINTAINER Adaikal Raj <adaikal.raj@gmail.com>  
RUN DEBIAN_FRONTEND=noninteractive apt update && \  
apt install -y curl wget && \  
curl -L https://www.opscode.com/chef/install.sh | bash && \  
wget http://github.com/opscode/chef-repo/tarball/master && \  
tar -zxf master && \  
mv chef-chef-repo* chef-repo && \  
rm master && \  
cd chef-repo/ && \  
mkdir .chef && \  
echo "cookbook_path [ '/chef-repo/cookbooks' ]" > .chef/knife.rb && \  
apt remove -y curl && \  
rm -Rf /var/lib/apt/lists/*  
WORKDIR /chef-repo  

