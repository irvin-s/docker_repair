FROM ubuntu:14.04  
MAINTAINER vitaly  
  
  
RUN apt-get update && apt-get install -y gfortran make g++ gnuplot git  
RUN git clone https://github.com/seliv55/isodyn.git  
WORKDIR isodyn  
RUN make clean && make  
RUN chmod a+x isodyn.out  
RUN cp isodyn.out /usr/bin/isodyn  
  
ENTRYPOINT ["isodyn"]  

