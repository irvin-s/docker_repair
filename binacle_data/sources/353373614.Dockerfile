FROM alpine

# Include dist
ADD dist/ /root/dist/

# Setup apt
RUN apk -U --no-cache add \
               build-base \
               git \
               libcap \
               libffi-dev \
               libressl-dev \
               linux-headers \
               py3-yarl \
               python3 \
               python3-dev && \ 

# Setup Tanner
    git clone --depth=1 https://github.com/mushorg/tanner /opt/tanner && \
    cp /root/dist/config.py /opt/tanner/tanner/ && \
    cd /opt/tanner/ && \
    pip3 install --no-cache-dir --upgrade pip setuptools && \
    pip3 install --no-cache-dir -r requirements.txt && \
    python3 setup.py install && \
    cd / && \
    
# Setup configs, user, groups
    chown -R nobody:nobody /opt/tanner && \

# Clean up
    apk del --purge \
            build-base \
            linux-headers \
            python3-dev && \
    rm -rf /root/* && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/cache/apk/*

# Start conpot
USER nobody:nobody
WORKDIR /opt/tanner
CMD tanner 
