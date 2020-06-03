# Google Cloud Bigtable Documentation  
# https://cloud.google.com/bigtable/docs/  
FROM google/cloud-sdk:alpine  
LABEL maintainer="Cesar Perez <cesar@bigtruedata.com>" \  
version="0.1" \  
description="Google Cloud Bigtable Emulator"  
  
RUN gcloud components install bigtable \  
&& gcloud components install beta  
  
EXPOSE 8086  
ENTRYPOINT ["gcloud", "beta", "emulators", "bigtable"]  
CMD ["start", "--host-port", "127.0.0.1:8086"]  

