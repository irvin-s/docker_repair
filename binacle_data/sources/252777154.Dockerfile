FROM alpine:3.2  
RUN apk --update add bash openssh-client curl coreutils  
ENV SHELL /bin/bash  
ADD setup setup  
ADD install_pmx_agent install_pmx_agent  
RUN chmod +x setup  
RUN chmod +x install_pmx_agent  
CMD "./setup"  

