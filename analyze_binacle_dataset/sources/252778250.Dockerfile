FROM i386/ubuntu:18.04  
MAINTAINER lozovsky <lozovsky@apriorit.com>  
  
# Refresh package repostories  
RUN apt-get update  
  
# Install essential packages for building Linux kernel modules  
# as well as all available kernel headers  
RUN apt-get install -y \  
build-essential \  
gcc \  
linux-headers-4.15.0-20-generic \  
sparse \  
&& exit  
  
# Remove cached packages and repository contents to conserve disk space  
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*  

