FROM alpine:latest  
MAINTAINER Colin O'Dell <colinodell@gmail.com>  
  
# Install bash, install ssh client, and disable host key checking  
RUN apk add \--update \--no-cache openssh-client bash && \  
mkdir -p ~/.ssh && \  
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config  
  
CMD ["/bin/bash"]  

