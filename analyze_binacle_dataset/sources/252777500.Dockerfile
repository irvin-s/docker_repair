# Docker container for installing BioPerl  
  
FROM ubuntu  
  
MAINTAINER Takeru Nakazato, chalkless@gmail.com  
  
RUN apt-get update && \  
apt-get install -y bioperl && \  
rm -rf /var/lib/apt/lists/*  
  
CMD echo -n "BioPerl VERSION: " && \  
perl -MBio::Perl -le 'print $Bio::Perl::VERSION' && \  
/bin/bash  
  

