FROM amazonlinux:latest  
  
RUN yum -y update && \  
yum -y install \  
python34-pip \  
zip  
  
RUN ln -s /usr/bin/pip-3.4 /usr/bin/pip  
RUN pip install --upgrade pip  
  
ADD build_lambda.sh /usr/local/bin  
RUN chmod +x /usr/local/bin/build_lambda.sh  
  
WORKDIR /src  
  
ENTRYPOINT ["build_lambda.sh"]  

