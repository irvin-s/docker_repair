FROM ubuntu:17.10  
  
RUN apt-get update && apt-get install -y \  
build-essential \  
curl \  
g++ \  
git \  
iputils-ping \  
libcairo2-dev \  
libjpeg8-dev \  
libpango1.0-dev \  
libgif-dev \  
python2.7 \  
python3.6 \  
python3.6-dev \  
python3-venv \  
sudo \  
tzdata \  
vim \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - \  
&& apt-get update && apt-get install -y nodejs \  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /app  
COPY . .  
  
RUN npm install --production  
CMD npm start

