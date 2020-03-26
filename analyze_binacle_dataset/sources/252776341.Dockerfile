#Docker container for hmmemit in hmmer  
FROM debian  
MAINTAINER Hidemasa Bono, bonohu@gmail.com  
  
# File add  
ADD Sod_Cu.hmm Sod_Cu.hmm  
  
# Install packages  
RUN apt-get update && \  
apt-get install -y hmmer &&\  
rm -rf /var/lib/apt/lists/*  
CMD ["hmmemit", "Sod_Cu.hmm"]  

