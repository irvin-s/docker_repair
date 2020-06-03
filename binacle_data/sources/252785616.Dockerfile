FROM comics/centos  
MAINTAINER Ian Merrick <MerrickI@Cardiff.ac.uk>  
  
##############################################################  
# Dockerfile Version: 0.1  
# Software: gbrowse  
# Software Version: latest available in CPAN  
# Software Website: https://github.com/GMOD/GBrowse  
# Description: the Generic Genome Browser  
##############################################################  
  
RUN yum install -y httpd \  
mod_fcgid \  
fcgi-perl ; \  
yum clean all  
  
RUN yum install -y \  
bzip2 \  
expat \  
expat-devel \  
gcc \  
gd \  
gd-devel \  
git \  
gmp-devel \  
graphviz \  
graphviz-devel \  
httpd \  
inkscape \  
libxml2 \  
libxml2-devel \  
make \  
mariadb-devel \  
ncurses-devel \  
openssl-devel \  
perl \  
perl-App-cpanminus \  
perl-bioperl \  
perl-CPAN \  
perl-GD \  
perl-Module-Build \  
perl-CPAN \  
perl-IO-String \  
perl-Capture-Tiny \  
perl-CGI-Session \  
perl-JSON \  
perl-JSON-Any \  
perl-libwww-perl \  
perl-DBD-SQLite \  
perl-File-NFSLock \  
perl-Net-SMTP-SSL \  
perl-Crypt-SSLeay \  
perl-Net-SSLeay \  
perl-Template-Toolkit \  
perl-local-lib \  
perl-Test-Most \  
unzip \  
wget \  
zlib-devel ; \  
yum clean all  
  
RUN cpanm SVG \  
CGI \  
DBI \  
DBD::mysql \  
DBD::SQLite \  
Statistics::Descriptive \  
Data::Stag \  
GD::Graph \  
GD::Graph::smoothlines \  
GD::SVG \  
Statistics::Lite \  
Statistics::LineFit \  
Compress::Zlib \  
IO::Zlib \  
Config::Simple \  
Pod::Usage \  
Algorithm::Cluster \  
Env \  
DB_File \  
CGI::Session \  
Crypt::SSLeay \  
DB_File::Lock \  
FCGI \  
File::NFSLock \  
Net::OpenID::Consumer \  
Net::SMTP::SSL \  
Parse::Apache::ServerStatus \  
Template \  
JSON \  
LWP \  
Module::Build \  
GD \  
Storable \  
IO::String \  
Capture::Tiny \  
File::Temp \  
Digest::MD5 \  
Statistics::Descriptive  
RUN cd / ; \  
git clone https://github.com/bioperl/bioperl-live.git ; \  
cd bioperl-live ; \  
git checkout tags/bioperl-release-1-6-901 ; \  
rm -rf .git ; \  
yes '' | perl Build.PL ; \  
./Build test ; \  
./Build install  
RUN cd / ; \  
cpanm Bio::Graphics ; \  
git clone https://github.com/GMOD/GBrowse ; \  
cd GBrowse ; \  
git checkout tags/release-2_55 ; \  
rm -rf .git ; \  
perl Build.PL ; \  
yes '' | ./Build test ; \  
yes 'n' | ./Build install ; \  
chown -R apache:apache /var/lib/gbrowse2 ; \  
cd /usr/share/httpd ; \  
mkdir -p .config/inkscape .gnome2 ; \  
chown apache:apache .config/inkscape .gnome2  
  
COPY gbrowse2.conf /etc/httpd/conf.d/gbrowse2.conf  
COPY gbrowse_entrypoint.sh /usr/local/bin/gbrowse_entrypoint.sh  
ENTRYPOINT ["/usr/local/bin/gbrowse_entrypoint.sh"]  
  

