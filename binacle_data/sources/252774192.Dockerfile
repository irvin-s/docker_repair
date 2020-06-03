FROM hashicorp/packer:light  
  
RUN apk add --update python3 jq  
RUN pip3 install boto3  

