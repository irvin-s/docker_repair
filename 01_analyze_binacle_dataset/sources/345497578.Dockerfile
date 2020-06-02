FROM phusion/passenger-ruby23:latest

ENV HOME="/root" RAILS_VERSION="~> 4.2"
RUN echo /root > /etc/container_environment/HOME \

CMD ["/sbin/my_init"]

COPY lentil_example_config.yml invoke.sh lentilapp.conf /tmp/

RUN /bin/bash -l -c 'apt-get update -qq && \
apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
cd /home/app && \
apt-get install netcat-openbsd && \
gem install rails --version "$RAILS_VERSION" && \
rails new --skip-spring --skip-turbolinks lentilapp -d postgresql && \
cd lentilapp && \
printf "gem '\''lentil'\''\ngem '\''whenever'\''\n" >> Gemfile && \
bundle update && \
cp /tmp/lentilapp.conf /etc/nginx/sites-enabled/lentilapp.conf && \
rm /etc/nginx/sites-enabled/default && \
cp -n /tmp/lentil_example_config.yml /home/app/lentilapp/lentil_config.yml && \
cp -n /home/app/lentilapp/lentil_config.yml /home/app/lentilapp/config/lentil_config.yml && \
chown -R app:app /home/app && \
rm -f /etc/service/nginx/down && \
mkdir -p /etc/my_init.d && \
cp /tmp/invoke.sh /etc/my_init.d/lentil_init.sh && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /pd_build'
