from nicescale/phusion-ubuntu:latest
run apt-get update
run DEBIAN_FRONTEND=noninteractive apt-get -y install exim4-daemon-light nginx php5-cli php5-fpm php5-curl php5-json git python
run sed -i -e "s/dc_local_interfaces=.*/dc_local_interfaces=''/" /etc/exim4/update-exim4.conf.conf && update-exim4.conf
run git clone https://github.com/Synchro/PHPMailer.git /opt/nicedocker/phpmailer

add . /opt/nicedocker
workdir /opt/nicedocker

run mkdir /etc/service/dnspod && cp dnspod.php /etc/service/dnspod/run
run mkdir /etc/service/nginx && cp nginx.sh /etc/service/nginx/run
run mkdir /etc/service/exim4 && cp exim4.sh /etc/service/exim4/run

run cp mta_prepare.sh /etc/my_init.d/

expose 25 80

