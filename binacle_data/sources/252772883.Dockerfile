FROM tensorflow/tensorflow:0.12.0-gpu  
  
RUN apt-get update && apt-get install -y emacs git zip  
  
RUN pip install numpy scipy matplotlib ipython jupyter pandas sympy nose h5py  
RUN pip install git+https://github.com/tflearn/tflearn.git  
  
WORKDIR /deep-tweet  
  
# exec >/dev/tty 2>/dev/tty </dev/tty  
RUN export TERM='vt100'  
  
COPY ./ /deep-tweet/  
  
ENV LANG C.UTF-8  

