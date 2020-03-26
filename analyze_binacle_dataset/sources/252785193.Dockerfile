FROM ubuntu  
MAINTAINER Cogniteev <tech@cogniteev.com>  
  
  
# Install prerequisites  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update && apt-get install -y \  
curl \  
openssh-client \  
python \  
python-openssl  
  
# Install gcloud  
RUN curl -o /tmp/google-cloud-sdk.tar.gz \  
https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz \  
&& tar -C /root -zxf /tmp/google-cloud-sdk.tar.gz \  
&& /root/google-cloud-sdk/install.sh \  
\--usage-reporting false \  
\--bash-completion true \  
\--rc-path /root/.bashrc \  
\--path-update true \  
&& rm -rf /tmp/google-cloud-sdk.tar.gz  
  
ENV PATH /root/google-cloud-sdk/bin:$PATH  
RUN yes | gcloud components update  
RUN yes | gcloud components update preview  
  
RUN ssh-keygen -t dsa -b 1024 -N "" -f /root/.ssh/google_compute_engine  
  
ENV CLOUDSDK_PYTHON_SITEPACKAGES 1  
ADD activate-service-accounts /root/  
COPY gcloud-auth /usr/local/bin/  
  
ONBUILD ADD projects/* /root/project-keys/  
ONBUILD RUN /root/activate-service-accounts  

