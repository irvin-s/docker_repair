FROM python:2.7  
MAINTAINER Chris <c@crccheck.com>  
  
RUN apt-get update -qq && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y \  
# For pdfs  
ghostscript imagemagick \  
# For lxml  
libxml2-dev libxslt1-dev \  
libpq-dev \  
> /dev/null && \  
apt-get clean && rm -rf /var/lib/apt/lists/*  
  
COPY requirements.txt /app/requirements.txt  
ENV PIP_DISABLE_PIP_VERSION_CHECK 1  
RUN pip install -r /app/requirements.txt  
  
COPY . /app  
WORKDIR /app  
EXPOSE 8000  
CMD ["make", "serve"]  

