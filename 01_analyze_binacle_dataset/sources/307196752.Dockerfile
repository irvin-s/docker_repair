FROM tensorflow/syntaxnet

LABEL maintainer="mathias@short-edition.com"
LABEL version="0.1"
LABEL description="Dockerfile intending to install syntaxnet syntactic parser and its python wrapper"

# Install SyntaxNet Wrapper requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip install -qr /tmp/requirements.txt

# Copy source code of wrapper
COPY . /root/syntaxnet-wrapper
WORKDIR /root/syntaxnet-wrapper
RUN cp ./syntaxnet_wrapper/config.yml.dist ./syntaxnet_wrapper/config.yml

# Install syntaxnet wrapper
RUN pip install .
