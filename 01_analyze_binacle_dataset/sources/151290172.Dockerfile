FROM silarsis/base
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>

RUN apt-get -yq install mysql-client
ADD run_mysql.sh /usr/local/bin/run_mysql.sh
RUN chmod +x /usr/local/bin/run_mysql.sh

CMD ["/usr/local/bin/run_mysql.sh"]
