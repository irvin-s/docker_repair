FROM tensorflow/tensorflow:0.12.0-rc0

MAINTAINER Nuno Silva <nuno.mgomes.silva@gmail.com>

# References: 
# - https://github.com/googledatalab/datalab/blob/master/containers/base/Dockerfile
# - https://cloud.google.com/ml/docs/how-tos/getting-set-up  [Setting up your environment - LOCAL: MAC/LINUX]

# Path configuration
ENV PATH $PATH:/tools/google-cloud-sdk/bin

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
	wget \
    unzip \
    supervisor \
    python-dev \ 
    python-pip \
    zlib1g-dev \
    libjpeg-dev \
    libblas-dev \
    liblapack-dev \
    libatlas-base-dev \
    gfortran && \
    
# Python dependencies
    pip install --upgrade \ 
    numpy \
    pandas \
    scipy \
    scikit-learn \
    pyyaml \
    requests \
    uritemplate \
    google-api-python-client && \
    
# Setup Google Cloud SDK
    mkdir -p /tools && \
    wget -nv https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip && \    
    unzip -qq google-cloud-sdk.zip -d /tools && \
    rm google-cloud-sdk.zip && \
    /tools/google-cloud-sdk/install.sh --usage-reporting=false \
        --path-update=false --bash-completion=false \
        --disable-installation-options && \
    /tools/google-cloud-sdk/bin/gcloud -q components update \
        gcloud core bq gsutil compute preview alpha beta && \
    touch /tools/google-cloud-sdk/lib/third_party/google.py && \
    
# Clean up
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/dpkg/info/* && \
    rm -rf /tmp/* && \
    rm -rf /root/.cache/* && \
    rm -rf /tools/google-cloud-sdk/.install && \
    rm -rf /usr/share/locale/* && \
    rm -rf /usr/share/i18n/locales/* && \
    cd /

# Install CloudML SDK
RUN pip install --upgrade --force-reinstall \ 
    https://storage.googleapis.com/cloud-ml/sdk/cloudml.latest.tar.gz && \

# Download the Cloud ML samples
    mkdir -p ~/google-cloud-ml && \
    cd ~/google-cloud-ml && \
    curl -L -o cloudml-samples.zip \ 
    https://github.com/GoogleCloudPlatform/cloudml-samples/archive/master.zip && \
    unzip cloudml-samples.zip && \
    mv cloudml-samples-master/ samples/
    
# Manage container shared folders
RUN rm -rf /content/* 

#copy supervisord configurations 
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


WORKDIR /content
VOLUME ["/content"]
CMD ["/usr/bin/supervisord"]
