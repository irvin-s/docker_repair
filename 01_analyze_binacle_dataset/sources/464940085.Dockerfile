FROM ubuntu:18.04
LABEL maintainer="Gigantum <hello@gigantum.com>"

# This is needed for tzdata to proceed, but should probably be set generally
ENV DEBIAN_FRONTEND=noninteractive

# Install system level dependencies
RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
    wget \
    nginx \
    python3-pip \
    python3-setuptools \
    gosu && \
    apt-get clean 

# add mitmproxy to track rstudio
RUN pip3 install -U pip 
RUN pip3 install wheel
RUN pip install mitmproxy
    
# Expose port for nginx
EXPOSE 8079
# Expose port for mitmproxy
EXPOSE 8080

# Overwrite nginx.conf it's our proxy.
COPY nginx.conf /etc/nginx/nginx.conf

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"] 


