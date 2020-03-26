FROM amancevice/pandas:0.20.3-python3  
  
# Install dependencies & add stanhope user  
RUN apt-get update && \  
apt-get install -y mdbtools && \  
pip install ardec click ipython && \  
useradd -b /home -U -m stanhope  
  
# Set up app ENV  
VOLUME /data /stanhope  
WORKDIR /data  
  
# Install app  
COPY stanhope /stanhope  
RUN pip install -e /stanhope  
ENTRYPOINT ["stanhope"]  
  
# Run as stanhope user  
USER stanhope  

