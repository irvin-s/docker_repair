from continuumio/anaconda  
  
RUN apt-get update --fix-missing && apt-get install -y unzip && apt-get clean  
  
# install comb-p  
RUN mkdir -p /comb-p  
RUN cd /comb-p  
RUN wget https://github.com/brentp/combined-pvalues/archive/v0.32.zip  
RUN unzip v0.32.zip  
RUN cd /combined-pvalues-0.32 && python setup.py install  

