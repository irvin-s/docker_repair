FROM hashicorp/terraform:0.11.3  
# Install required packages  
RUN apk add --update bash jq  
  
ENTRYPOINT ["/bin/sh", "-c"]  
  

