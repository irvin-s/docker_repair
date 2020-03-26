# AWS Command Line Interface Dockerfile  
  
FROM alpine:3.6  
  
RUN apk --no-cache add \  
# Install awscli dependencies:  
py-pip \  
groff \  
less \  
&& pip install --upgrade \  
pip \  
awscli \  
# Clean up obsolete files:  
&& rm -rf \  
# Clean up any temporary files:  
/tmp/* \  
# Clean up the pip cache:  
/root/.cache \  
# Remove any compiled python files (compile on demand):  
`find / -regex '.*\\.py[co]'`  
  
ENTRYPOINT ["aws"]  

