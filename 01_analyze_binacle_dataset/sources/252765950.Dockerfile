FROM ubuntu:16.04  
RUN apt-get update  
RUN apt-get install -y sudo git  
RUN git clone https://github.com/karek314/lisk-php  
WORKDIR /lisk-php  
RUN bash ./setup.sh  
ADD ./run.sh ./run.sh  
RUN chmod +x ./run.sh  
ENTRYPOINT ["./run.sh"]  
CMD ["--help"]

