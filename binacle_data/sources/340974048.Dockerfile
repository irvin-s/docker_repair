FROM nginx:latest

# Download packages
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get update && apt-get install -y curl \
                                         git  \
                                         ruby \
                                         ruby-dev \
                                         build-essential \
                                         nodejs \
                                         rubygems

# Copy angular files
COPY . /usr/share/nginx

# Installation
WORKDIR /usr/share/nginx
RUN npm install npm -g
RUN npm install -g bower
RUN npm install -g grunt-cli
RUN gem install sass
RUN gem install compass
RUN npm cache clean
RUN npm install
RUN bower --allow-root install -g

# Building
RUN grunt build

# Open port and start nginx
EXPOSE 80
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
