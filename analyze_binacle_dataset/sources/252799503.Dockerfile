FROM ubuntu:latest  
  
LABEL maintainer "diatomic.ge <diatomic.ge@gmail.com>"  
  
# Install build tools.  
RUN apt-get update && apt-get install -y \  
autoconf \  
automake \  
bison \  
gcc \  
git \  
gperf \  
make \  
sed  
  
# Download and build HellCore.  
RUN git clone https://github.com/necanthrope/HellCore.git /tmp/hellcore && \  
cd /tmp/hellcore && \  
git checkout unicode_omega && \  
./build.sh  
  
# Run HellCore.  
CMD /bin/bash -c \  
'cd /tmp/hellcore && ./src/moo hellcore.db hellcore.db.new 7777'  
  
# Expose the HellCore port.  
EXPOSE 7777  

