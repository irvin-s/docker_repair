FROM tensorflow/tensorflow  
RUN apt-get update && apt-get install -y \  
python-pip \  
cython \  
git \  
wget  
RUN pip install opencv-python  
  
RUN cd "/" && \  
git clone https://github.com/thtrieu/darkflow.git &&\  
cd darkflow && \  
pip install . && \  
cd "/" && \  
rm -rf darkflow  
  
ADD Darkflow_Tiny_Yolo_demo.ipynb /notebooks  

