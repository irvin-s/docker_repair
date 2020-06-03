FROM lsiobase/alpine.python  
MAINTAINER Ben White <ben@cuckoo.org>  
ADD root /  
WORKDIR /root  
RUN git clone https://github.com/biwhite/Packt-Publishing-Free-Learning.git  
RUN cd Packt-Publishing-Free-Learning && git checkout add-cfgpath-argument  
RUN pip install -r /root/Packt-Publishing-Free-Learning/requirements.txt  
ENTRYPOINT ["/init"]  
  

