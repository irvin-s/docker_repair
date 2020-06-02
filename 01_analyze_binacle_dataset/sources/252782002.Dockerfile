ARG VERSION=latest  
FROM chschroeder/text-classification-plotting:${VERSION}  
  
USER root  
  
RUN apt-get install -y --no-install-recommends python-matplotlib  
  
RUN pip install notebook==5.4.0  
  
USER primo  
  
CMD ["jupyter", "notebook", "--port=8888", "--ip=0.0.0.0"]  

