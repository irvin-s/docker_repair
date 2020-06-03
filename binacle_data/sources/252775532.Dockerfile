FROM debian:stretch  
  
# Install pacparser Python module, and Python  
# We use Debian's packaged version of Python, which can find this module  
RUN apt-get update && apt-get install -y --no-install-recommends \  
python3 \  
python3-pacparser \  
python3-requests \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY . .  
  
CMD [ "sh", "./test.sh" ]  

