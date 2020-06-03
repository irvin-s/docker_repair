FROM httpd:2.4  
RUN apt-get update && apt-get install -y \  
cpanminus \  
make \  
gcc  
  
RUN cpanm \  
Template \  
File::Find::Rule \  
File::Slurp \  
Math::Round::Var \  
Switch  
  
RUN apt-get install -y \  
awstats \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
COPY docker/httpd.conf /usr/local/apache2/conf/httpd.conf  
COPY docker/htpasswd /usr/local/apache2/htpasswd  
COPY docker/awstats/etc /etc/awstats  
COPY docker/awstats/data /var/lib/awstats  
  
COPY index.pl /usr/local/apache2/htdocs  
COPY _system /usr/local/apache2/htdocs/_system  
  
RUN ln -s /usr/lib/cgi-bin/awstats.pl /usr/local/apache2/htdocs/awstats.pl  

