FROM python  
RUN apt-get -y update  
RUN apt-get -y install python-all-dev  
RUN apt-get -y install build-essential  
RUN apt-get -y install swig  
RUN apt-get -y install libpulse-dev  
RUN apt-get -y install python-pip  
RUN apt-get -y install software-properties-common python-software-properties  
RUN apt-get -y install libav-tools  
RUN pip install pocketsphinx  
RUN pip install google-api-python-client  
RUN pip install SpeechRecognition  
RUN python  

