###########################################################  
# Dockerfile to build container lgtseek core image  
# Based on Ubuntu  
############################################################  
  
FROM adkinsrs/workflow:3.2.0  
  
MAINTAINER Shaun Adkins <sadkins@som.umaryland.edu>  
  
EXPOSE 80  
  
#--------------------------------------------------------------------------------  
# BASICS  
  
# 1) Install general things  
# 2) Install Perl things  
# 3) Install Debian things  
# 4) Make various directories.  
### /opt/packages is where software installs will be placed or symlinked to  
### /var/www/html is where the Ergatis site and pipeline building UI will be  
  
COPY deb/lib*.deb /tmp/  
  
RUN apt-get -q update && apt-get -q install -y --no-install-recommends \  
apache2 \  
autoconf \  
build-essential \  
cpanminus \  
dh-make-perl \  
git \  
libapache2-mod-php5 \  
perl \  
php5 \  
vim \  
wget \  
zip \  
zlib1g-dev \  
libcpan-meta-perl \  
libcdb-file-perl \  
libcgi-session-perl \  
libconfig-inifiles-perl \  
libdate-manip-perl \  
libfile-spec-perl \  
libhtml-template-perl \  
libio-tee-perl \  
libjson-perl \  
liblog-log4perl-perl \  
libmath-combinatorics-perl \  
libperlio-gzip-perl \  
libxml-parser-perl \  
libxml-rss-perl \  
libxml-twig-perl \  
libxml-writer-perl \  
libxml-libxml-perl \  
&& apt-get -q clean autoclean \  
&& apt-get -q autoremove -y \  
&& rm -rf /var/lib/apt/lists/* \  
&& cpanm --force Term::ProgressBar \  
&& dpkg -i \  
/tmp/libfile-mirror-perl_0.10-1_all.deb \  
/tmp/liblog-cabin-perl_0.06-1_all.deb \  
&& rm /tmp/libfile-mirror-perl_0.10-1_all.deb \  
/tmp/liblog-cabin-perl_0.06-1_all.deb \  
&& chmod 777 /opt \  
&& mkdir /opt/packages && chmod 777 /opt/packages \  
&& mkdir -p /var/www/html && chmod 777 /var/www/html  
  
#--------------------------------------------------------------------------------  
# APACHE SETUP  
COPY 000-default.conf /etc/apache2/sites-enabled/.  
COPY ergatis.conf /etc/apache2/conf-enabled/.  
RUN a2enmod cgid  
RUN a2enmod php5  
  
#--------------------------------------------------------------------------------  
# SCRATCH  
  
RUN mkdir -m 0777 -p /usr/local/scratch \  
&& mkdir -m 0777 /usr/local/scratch/ergatis \  
&& mkdir -m 0777 /usr/local/scratch/ergatis/archival \  
&& mkdir -m 0777 /usr/local/scratch/workflow \  
&& mkdir -m 0777 /usr/local/scratch/workflow/id_repository \  
&& mkdir -m 0777 /usr/local/scratch/workflow/runtime \  
&& mkdir -m 0777 /usr/local/scratch/workflow/runtime/pipeline \  
&& mkdir -m 0777 /usr/local/scratch/workflow/scripts \  
&& mkdir -m 0777 /tmp/pipelines_building  
  
#--------------------------------------------------------------------------------  
# ERGATIS SETUP  
  
# Set up lib directory  
RUN mkdir -p /opt/ergatis/lib/  
COPY lib/ /opt/ergatis/lib/  
ENV PERL5LIB=/opt/ergatis/lib/perl5  
  
# Set up site  
RUN mkdir /var/www/html/ergatis  
COPY htdocs/ /var/www/html/ergatis/  
COPY ergatis.ini /var/www/html/ergatis/cgi/  
  
# Change the level of debugging  
COPY log4j.properties /opt/workflow/  
  
# Set up area to store scripts  
RUN mkdir -p /opt/scripts  
COPY create_wrappers.sh /opt/scripts  
COPY perl2wrapper_ergatis.pl /opt/scripts  
COPY python2wrapper_ergatis.pl /opt/scripts  
COPY julia2wrapper_ergatis.pl /opt/scripts  
  
# Lastly, set working directory to root directory  
WORKDIR /  
# ... and start apache  
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]  

