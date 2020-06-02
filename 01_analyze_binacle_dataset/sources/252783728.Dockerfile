FROM billyzhang2010/python-pip:latest  
  
RUN apt-get update && apt-get install -y python-dev && pip install simiki  
  
RUN apt install git -y  
  
RUN cd /home  
  
#RUN git clone https://hustbill@github.com/hustbill/goWiki.git demo  
EXPOSE 8000  
#CMD cd demo/mywiki && simiki g && simiki p -w --host 0.0.0.0 --port 8000  
#CMD ["/bin/bash"]  

