FROM cl0sey/buildkite-agent:beta  
  
RUN apk --no-cache add gawk sed grep bc coreutils \  
groff less python && \  
mkdir -p /aws && \  
pip install awscli  

