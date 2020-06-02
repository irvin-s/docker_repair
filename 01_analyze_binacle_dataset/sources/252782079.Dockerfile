FROM node  
  
RUN cd ~ && \  
wget https://bootstrap.pypa.io/get-pip.py && \  
python get-pip.py  
RUN pip install spade opencv-python  

