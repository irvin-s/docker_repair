FROM gliderlabs/alpine:3.2  
MAINTAINER Allan Costa "allan@cloudwalk.io"  
RUN apk --update add py-pip  
RUN pip install awscli  
  
WORKDIR /home/aws/  
  
COPY aws_cli.py /home/aws/aws_cli.py  
  
ENTRYPOINT ["/home/aws/aws_cli.py"]  

