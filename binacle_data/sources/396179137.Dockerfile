FROM debian:9
ENV DEBIAN_FRONTEND noninteractive

# Speedup
RUN echo 'force-unsafe-io' | tee /etc/dpkg/dpkg.cfg.d/02apt-speedup && \
    echo 'DPkg::Post-Invoke {"/bin/rm -f /var/cache/apt/archives/*.deb || true";};' | tee /etc/apt/apt.conf.d/no-cache && \
    echo 'Acquire::http {No-Cache=True;};' | tee /etc/apt/apt.conf.d/no-http-cache

RUN apt-get update && \
    apt-get install -y \
        build-essential \
        libffi-dev \
        && \
    apt-get clean

RUN apt-get install -y \
        python \
        python-dev \
        python-pip \
        && \
    apt-get clean


RUN apt-get install -y \
        libfuzzy-dev \
        && \
    apt-get clean


COPY . /code
RUN cd /code && \
    BUILD_LIB=0 pip install . && \
    pip install pytest && \
    py.test
