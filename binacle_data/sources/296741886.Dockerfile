FROM python:2.7

# Install Docker
ENV DOCKER_CONFIG=/tmp/
RUN curl https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz | tar xz -C /tmp/ \
    && chmod +x /tmp/docker && mv -f /tmp/docker/* /usr/local/bin/

# Install packages required for the tests
COPY test-requirements.txt /tmp/test-requirements.txt
RUN pip install --no-cache-dir -r /tmp/test-requirements.txt

# Install the package requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt
