# blobxfer  
#  
# Microsoft tool for blob transfer to and from Azure.  
#  
# docker run -it --rm \  
# -v $(pwd)/blobdata:/blobdata \  
# -w /blobdata \  
# --name app_blob \  
# draco1114/blobxfer  
#  
FROM python:2.7  
MAINTAINER Michael Thomas <draco1114@gmail.com>  
  
RUN apt-get update -qq && \  
apt-get install -qqy --no-install-recommends ca-certificates && \  
apt-get clean all && \  
pip install --upgrade pip -q && \  
pip install blobxfer -q  
  
ENTRYPOINT [ "blobxfer" ]  

