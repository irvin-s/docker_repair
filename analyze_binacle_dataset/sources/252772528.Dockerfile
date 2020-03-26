FROM mbartoli/caffe  
MAINTAINER awentzonline  
  
RUN apt-get update -y && apt-get install -y wget  
  
RUN /root/caffe/data/ilsvrc12/get_ilsvrc_aux.sh  
RUN python /root/caffe/scripts/download_model_binary.py \  
/root/caffe/models/bvlc_googlenet  
  
ADD ./webapp /webapp  
WORKDIR /webapp  
RUN pip install -r requirements.txt  
  
COPY ./model /model  
  
EXPOSE 5000  
CMD ["python", "/webapp/app.py", "-p 5000"]  

