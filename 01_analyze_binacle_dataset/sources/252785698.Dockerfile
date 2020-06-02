FROM companyservice/tornado  
MAINTAINER Jimin Huang "windworship2@163.com"  
ADD viewer_code /server  
ENV "SERVICE_NAME=viewer"  

