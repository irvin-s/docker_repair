FROM alpine:3.7  
# Install python and node requirements  
RUN apk add \  
\--no-cache \  
py-pillow \  
py-pip \  
python-dev \  
\  
nodejs \  
nodejs-npm  
# Install python packages with pip  
RUN pip install \  
\--use-wheel --upgrade \  
Pygments \  
alabaster \  
commonmark \  
docutils \  
mkdocs \  
mock \  
recommonmark \  
setuptools  
  
# Install node packages with npm  
RUN npm install -g markdownlint-cli --save-dev  
  
# Add the check-and-build custom script  
ADD ./utils/check-and-build /check-and-build  
  
ENTRYPOINT ["/check-and-build"]  

