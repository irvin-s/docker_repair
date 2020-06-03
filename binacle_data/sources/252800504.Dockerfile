FROM dominicbreuker/vgg_weights:latest  
  
RUN pip install -U pip && \  
pip install keras && \  
pip install h5py && \  
pip install pillow  
  
COPY vgg_16 /vgg_16  
COPY keras.json /root/.keras/  
  
RUN ["python", "/vgg_16/model_test.py"]  
  
CMD ["python", "/vgg_16/extractor.py", "--help"]  

