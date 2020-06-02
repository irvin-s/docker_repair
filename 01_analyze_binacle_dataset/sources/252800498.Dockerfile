FROM dominicbreuker/deep_drive_weights:latest  
  
RUN pip install -U pip && \  
pip install keras && \  
pip install h5py && \  
pip install pillow  
  
COPY deep_drive /deep_drive  
COPY keras.json /root/.keras/  
  
RUN ["python", "/deep_drive/model_test.py"]  
  
CMD ["python", "/deep_drive/extractor.py", "--help"]  

