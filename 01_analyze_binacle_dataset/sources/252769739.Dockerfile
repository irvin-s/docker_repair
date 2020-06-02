FROM resin/armhf-alpine:3.6  
LABEL maintainer "Adrien Girardeau <adigir25@gmail.com>"  
  
RUN [ "cross-build-start" ]  
  
RUN apk add -U --no-cache python2 py2-pip iptables ip6tables  
RUN pip install redis ipaddress  
  
COPY logwatch.py /  
  
RUN [ "cross-build-end" ]  
  
CMD ["python2", "-u", "/logwatch.py"]  

