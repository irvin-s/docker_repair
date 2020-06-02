FROM debian:latest  
  
RUN apt-get update && apt-get install -y \  
python3 \  
python3-pytest \  
python3-pytest-cov \  
vim  
  
COPY ./ /root/undefined-is-NaN  
  
CMD ["/bin/bash"]  

