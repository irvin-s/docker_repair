FROM alpine  
  
# Update  
RUN apk add --update python3 py3-pip  
  
# Bundle app source  
COPY src /ipn  
  
# Install dependencies  
RUN pip3 install -r /ipn/requirements.txt  
  
EXPOSE 80  
CMD python3 /ipn/ipn.py  

