FROM nginx:latest

RUN rm /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/nginx.conf

COPY nginx.conf /etc/nginx
COPY jenkins.conf /etc/nginx/conf.d

# copy from GitHub example
# RUN  apt-get update \
#  && apt-get install -y wget \
#  && rm -rf /var/lib/apt/lists/*
  
# RUN wget https://raw.githubusercontent.com/AnghelLeonard/SpringMVCDemo/master/nginx.conf -P /etc/nginx
# RUN wget https://raw.githubusercontent.com/AnghelLeonard/SpringMVCDemo/master/jenkins.conf -P /etc/nginx/conf.d