FROM dominicbreuker/resnet_50_docker_base:latest  
  
RUN pip install -U pip && \  
pip install 'keras==1.2.1' && \  
pip install 'h5py==2.6.0' && \  
pip install 'pillow==4.0.0' && \  
pip install 'tqdm==4.11.2'  
  
COPY resnet_50/ /resnet_50/  
  
RUN ["python", "/resnet_50/model_test.py"]  
  
CMD ["python", "/resnet_50/extractor.py", "--help"]  

