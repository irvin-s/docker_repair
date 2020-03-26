FROM python:3.6

# Create app directory
WORKDIR /kub-generator

# Install app dependencies
COPY coreos-kubernetes-generator/src/requirements.txt ./

# Install additional requirements
RUN apt-get update && apt-get install -y genisoimage && \
ln -s /usr/bin/genisoimage /usr/bin/mkisofs && \
pip install -r requirements.txt

# Bundle app source
COPY coreos-kubernetes-generator /kub-generator

# Entry point
CMD [ "python", "./generate_template.py" ]
