FROM phusion/passenger-nodejs:latest

# Copy Files
RUN mkdir -p /home/app/webconfig \
/home/app/webconfig/public \
/home/app/webconfig/tmp \
/etc/my_init.d

WORKDIR /home/app/webconfig

COPY . /home/app/webconfig/
# Create directories
ENV HOME /home/app
CMD ["/sbin/my_init"]
RUN apt-get update -qq && \
apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
mv /home/app/webconfig/webcfg_init.sh /etc/my_init.d/webcfg_init.sh && \
npm install && \
./node_modules/bower/bin/bower --allow-root install && \
npm cache clean && \
./node_modules/bower/bin/bower --allow-root cache clean && \
chown -R app:app /home/app && \
mv /home/app/webconfig/webconfig.conf /etc/nginx/sites-enabled/webconfig.conf && \
rm /etc/nginx/sites-enabled/default && \
rm -f /etc/service/nginx/down && \
curl -sSL https://get.docker.com/ | sh  && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /pd_build

