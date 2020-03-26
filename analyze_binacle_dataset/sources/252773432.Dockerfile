# Google Cloud Pub/Sub Documentation  
# https://cloud.google.com/pubsub/docs/  
FROM google/cloud-sdk  
LABEL maintainer="Cesar Perez <cesar@bigtruedata.com>" \  
version="0.1" \  
description="Google Cloud Pub/Sub Emulator"  
  
EXPOSE 8538  
VOLUME /data  
  
ENTRYPOINT ["gcloud", "beta", "emulators", "pubsub"]  
CMD ["start", "--host-port=127.0.0.1:8538", "--data-dir=/data"]  

