FROM python:2.7-alpine  
  
RUN apk update && apk add bind  
  
ADD dhcpharvester.py /dhcpharvester.py  
ENTRYPOINT [ "python", "/dhcpharvester.py" ]  

