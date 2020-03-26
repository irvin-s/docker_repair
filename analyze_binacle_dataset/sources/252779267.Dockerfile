FROM alpine:3.6  
MAINTAINER c0ldcat <c0ldcat3z@gmail.com>  
  
# Install required packages  
RUN apk add --no-cache ca-certificates python3 py-pip imagemagick  
RUN update-ca-certificates  
  
# Install python_telegram_bot  
RUN pip3 install python_telegram_bot  
  
# Copy file  
COPY *.py /  
  
# Declare Environment Variables  
ENV TOKEN YOU_TOKEN  
  
CMD python3 /daemon.py -t $TOKEN  

