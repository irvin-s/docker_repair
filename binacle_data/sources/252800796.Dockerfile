FROM tensorflow/tensorflow  
  
RUN pip install textgenrnn flask  
  
WORKDIR /src  
COPY . /src  
  
CMD ["python", "app.py"]

