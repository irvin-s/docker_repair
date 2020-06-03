FROM ubuntu:16.04  
RUN apt-get clean && apt-get update  
RUN apt-get install locales  
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
  
#RUN curl https://www.yahoo.com  
RUN apt-get update  
RUN apt-get install \  
python3 \  
python3-pip \  
python3-dev \  
supervisor \  
vim curl \  
-y  
ADD vimrc /root/.vimrc  
  
RUN pip3 install \  
xgboost==0.6a2 \  
lightgbm==2.1.0 \  
sklearn \  
joblib \  
pandas \  
numpy \  
tqdm  
  
  
EXPOSE 80  
  
#CMD ["/usr/bin/supervisord"]  

