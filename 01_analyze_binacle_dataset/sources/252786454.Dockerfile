FROM dockercraft/mysql-client:15.1  
MAINTAINER Daniel <daniel@topdevbox.com>  
  
# How-To  
# Local Build: docker build -t mysqltuner .  
# Local Run: docker run -it --rm mysqltuner  
ENV PACKAGES "ca-certificates openssl perl perl-doc"  
RUN apk add --update $PACKAGES \  
&& rm -rf /var/cache/apk/*  
  
RUN wget https://github.com/major/MySQLTuner-perl/archive/1.7.2.zip \  
&& unzip 1.7.2.zip \  
&& rm 1.7.2.zip \  
&& cp /MySQLTuner-perl-1.7.2/mysqltuner.pl /bin/mysqltuner \  
&& cp /MySQLTuner-perl-1.7.2/basic_passwords.txt /bin/basic_passwords.txt \  
&& cp /MySQLTuner-perl-1.7.2/vulnerabilities.csv /bin/vulnerabilities.csv \  
&& rm -R /MySQLTuner-perl-1.7.2  
  
ENTRYPOINT ["mysqltuner"]  

