FROM python:3-slim-stretch  
  
RUN mkdir /home/pelletti  
  
COPY . /home/pelletti  
  
CMD [ "python", "/home/pelletti/main.py"]

