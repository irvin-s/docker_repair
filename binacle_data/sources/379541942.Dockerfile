FROM alpine:3.8

# Install required alpine linux packages.
RUN apk update
RUN apk add \
    git \
    perl \
    perl-dev \
    musl-dev \
    python \
    apache2 \
    gcc \
    make \
    perl-app-cpanminus \
    perl-namespace-autoclean \
    gdbm \
    apache2-dev \
    curl \
    apache2-utils \
    apache2-ssl \
    shadow \
    vim

# Install modperl
RUN cd /tmp && \
    wget http://apache.org/dist/perl/mod_perl-2.0.10.tar.gz && \
    tar -xzf mod_perl-2.0.10.tar.gz && \
    cd mod_perl-2.0.10/ && \
    perl Makefile.PL MP_APXS=/usr/bin/apxs && \
    make && make install

# Load modperl in httpd conf
RUN echo >> /etc/apache2/httpd.conf && \
    echo "LoadModule perl_module /usr/lib/apache2/mod_perl.so" >> /etc/apache2/httpd.conf

# Build Crypt::Rijndael perl module manually because we need to apply a patch
# to rijndael.h.
RUN cd /tmp && \
    wget https://cpan.metacpan.org/authors/id/L/LE/LEONT/Crypt-Rijndael-1.13.tar.gz && \
    tar -xzf Crypt-Rijndael-1.13.tar.gz && \
    cd Crypt-Rijndael-1.13/ && \
    perl Makefile.PL && \
    sed -i s/__uint8_t/uint8_t/g rijndael.h && \
    sed -i s/__uint32_t/uint32_t/g rijndael.h && make install

# Install the remaining required perl modules using cpanm.
RUN cpanm --notest --no-man-pages --no-wget --curl \
    Moose \
    MooseX::Types \
    MooseX::ConfigFromFile \
    MooseX::Getopt \
    MooseX::Role::Parameterized \
    MooseX::SimpleConfig \
    MooseX::StrictConstructor \
    MooseX::Types::DateTime \
    Time::HiRes \
    Time::Piece \
    Catalyst::Devel \
    Catalyst::Plugin::RequireSSL \
    Catalyst::Plugin::Session::Store::FastMmap \
    JSON Catalyst::View::JSON \
    Template::Plugin::Filter::Minify::CSS \
    Template::Plugin::Filter::Minify::JavaScript \
    Catalyst::Plugin::Cache::FastMmap \
    Catalyst::Plugin::UploadProgress \
    HTML::GenerateUtil \
    Class::Factory JSON::XS \
    Digest Archive::Zip \
    Data::Validate::URI \
    Log::Handler \
    Crypt::OpenPGP \
    Params::Classify \
    Variable::Magic \
    DateTime \
    Class::ISA \
    Catalyst::Authentication::User::Hash \
    Catalyst::Plugin::Session::State::Cookie \
    Catalyst::View::TT \
    Archive::Tar \
    Catalyst::Plugin::ConfigLoader::Environment

# Set up deployment dirs.
RUN mkdir /var/ibexfarm && \
    git clone https://github.com/addrummond/ibexfarm.git /var/ibexfarm/ibexfarm && \
    chown -R apache:apache /var/ibexfarm/

# Checkout the revision of github.com/addrummond/ibex corresponding to 0.3.9
# and create a tarball.
RUN cd /tmp && \
    git clone https://github.com/addrummond/ibex && \
    cd ibex && \
    git checkout 9e903f9 && \
    rm -rf .git* && \
    rm -rf docs && \
    rm -rf contrib && \
    rm -f LICENSE README example_lighttpd.conf mkdist.sh server_conf.py && \
    cd .. && \
    tar -czf ibex-deploy.tar.gz ibex && \
    mv ibex-deploy.tar.gz /var/ibexfarm

RUN touch /etc/apache2/conf.d/httpdpasswd && \
    chown apache:apache /etc/apache2/conf.d/httpdpasswd

# This is the dir apache2 wants to put its PID file in.
RUN mkdir /run/apache2

# Main ibex farm config.
RUN printf "---\n\
name: IbexFarm\n\
\n\
url_prefix: '/'\n\
\n\
webmaster_name: 'IBEX_WEBMASTER'\n\
webmaster_email: 'IBEX_WEBMASTER_EMAIL'\n\
\n\
ibex_archive: '/var/ibexfarm/ibex-deploy.tar.gz'\n\
ibex_archive_root_dir: 'ibex'\n\
ibex_version: '0.3.9'\n\
deployment_dir: '/ibexdata/deploy'\n\
deployment_www_dir: '/ibexdata/ibexexps'\n\
\n\
max_fname_length: 150\n\
\n\
dirs: [ 'js_includes', 'css_includes', 'data_includes', 'chunk_includes', 'server_state', 'results' ]\n\
sync_dirs: [ 'js_includes', 'css_includes', 'data_includes', 'chunk_includes', 'server_state' ]\n\
dirs_to_types:\n\
  js_includes: 'text/javascript'\n\
  css_includes: 'text/css'\n\
  data_includes: 'text/javascript'\n\
  chunk_includes: 'text/html'\n\
  server_state: 'text/plain'\n\
  results: 'text/plain'\n\
optional_dirs:\n\
  server_state: 1\n\
  results: 1\n\
writable: [ 'data_includes/*', 'results/*', 'server_state/*','chunk_includes/*' ]\n\
\n\
enforce_quotas: 0\n\
quota_max_files_in_dir: 500\n\
quota_max_file_size: 1048576\n\
quota_max_total_size: 1048576\n\
quota_record_dir: '/tmp/quota'\n\
\n\
password_protect_apache:\n\
    htpasswd: '/usr/bin/htpasswd'\n\
    passwd_file: '/etc/apache2/conf.d/httpdpasswd'\n\
\n\
max_upload_size_bytes: 1048576\n\
\n\
experiment_password_protection: Apache\n\
\n\
git_path: '/usr/bin/git'\n\
git_checkout_timeout_seconds: 25\n\
\n\
event_log_file: '/dev/stdout'\n\
\n\
experiment_base_url: '/ibexexps/'\n\
\n\
python_hashbang: '/usr/bin/python'\n\
\n\
config_url: 'http://localhost/ajax/config'\n\
config_permitted_hosts: ['localhost', '::1']\n" > /var/ibexfarm/ibexfarm/ibexfarm.yaml

## Choose port Apache listens on based on env var
RUN sed -i 's/^Listen[\t ].*/Listen ${IBEXFARM_port}'/ /etc/apache2/httpd.conf

## Append to Apache config
RUN printf "ServerName localhost\n\
\n\
PerlSwitches -I/var/ibexfarm/ibexfarm/lib\n\
PerlModule IbexFarm\n\
\n\
<LocationMatch \"^/(?!(?:static/|ibexexps/))\">\n\
    SetHandler modperl\n\
    PerlResponseHandler IbexFarm\n\
</LocationMatch>\n\
\n\
Alias /static/ /var/ibexfarm/ibexfarm/root/static/\n\
<Directory /var/ibexfarm/ibexfarm/root/static/>\n\
    Options none\n\
    Require all granted\n\
</Directory>\n\
<Location /static>\n\
    SetHandler default-handler\n\
</Location>\n\
\n\
DocumentRoot \"/var/www\"\n\
\n\
AddHandler cgi-script .py\n\
Alias "/ibexexps" "/ibexdata/ibexexps"\n\
\n\
<Directory \"/ibexdata/ibexexps\" >\n\
    Options +ExecCGI +FollowSymLinks\n\
    AllowOverride AuthConfig\n\
    DirectoryIndex experiment.html\n\
    Require all granted\n\
</Directory>\n\
#\n\
# Relax access to content within /var/www.\n\
#\n\
<Directory \"/var/www\">\n\
    AllowOverride None\n\
    # Allow open access:\n\
    Require all granted\n\
</Directory>\n\
\n\
# Log to stdout/stderr\n\
ErrorLog /dev/stderr\n\
TransferLog /dev/stdout\n\
\n\
LoadModule cgi_module modules/mod_cgi.so\n\
# SetEnv rather than PerlSetEnv for IBEXFARM_config_url because\n\
# it needs to go through to CGI scripts, not modperl code.\n\
SetEnv IBEXFARM_config_url \"\${IBEXFARM_config_url}\"\n\
PerlSetEnv IBEXFARM_host \"\${IBEXFARM_host}\"\n\
PerlSetEnv IBEXFARM_url_prefix \"\${IBEXFARM_url_prefix}\"\n\
PerlSetEnv IBEXFARM_webmaster_email \"\${IBEXFARM_webmaster_email}\"\n\
PerlSetEnv IBEXFARM_webmaster_name \"\${IBEXFARM_webmaster_name}\"\n\
PerlSetEnv IBEXFARM_config_secret \"\${IBEXFARM_config_secret}\"\n\
PerlSetEnv IBEXFARM_config_url_envvar \"\${IBEXFARM_config_url_envvar}\"\n" >> /etc/apache2/httpd.conf

# Apache https config
RUN printf "LoadModule ssl_module modules/mod_ssl.so\n\
LoadModule socache_shmcb_module modules/mod_socache_shmcb.so\n\
SSLRandomSeed startup file:/dev/urandom 512\n\
SSLRandomSeed connect builtin\n\
SSLCipherSuite HIGH:MEDIUM:!MD5:!RC4:!3DES:!ADH\n\
SSLProxyCipherSuite HIGH:MEDIUM:!MD5:!RC4:!3DES:!ADH\n\
SSLHonorCipherOrder on\n\
SSLProtocol all -SSLv3\n\
SSLProxyProtocol all -SSLv3\n\
SSLPassPhraseDialog  builtin\n\
SSLSessionCache        \"shmcb:/var/cache/mod_ssl/scache(512000)\"\n\
SSLSessionCacheTimeout  300\n\
<VirtualHost *:443>\n\
ServerName \"\${IBEXFARM_host}:443\"\n\
ServerAdmin \"\${IBEXFARM_webmaster_email}\"\n\
ErrorLog /dev/stderr\n\
TransferLog /dev/stdout\n\
SSLEngine on\n\
SSLCertificateFile      /ibexdata/cert.pem\n\
SSLCertificateKeyFile   /ibexdata/privkey.pem\n\
SSLCertificateChainFile /ibexdata/chain.pem\n\
CustomLog /dev/stdout \"%%t %%h %%{SSL_PROTOCOL}x %%{SSL_CIPHER}x \\\"%%r\\\" %%b\"\n\
</VirtualHost>\n" > /var/ibexfarm/ssl.conf

# Create wrapper we use to run httpd, including or not including ssl
# config depending on port.
RUN rm -f /etc/apache2/conf.d/ssl.conf && \
    echo '#!/bin/sh' > /var/ibexfarm/start.sh && \
    printf "rm -f /etc/apache2/conf.d/ssl.conf\nif [ \"\$IBEXFARM_port\" = \"443\" ]; then\n  ln -s /var/ibexfarm/ssl.conf /etc/apache2/conf.d/ssl.conf\nfi\nexec /usr/sbin/httpd -D FOREGROUND\n" >> /var/ibexfarm/start.sh && \
    chmod +x /var/ibexfarm/start.sh

# Fix handling of base URL in Catalyst
RUN echo 'sub auto : Private { my ($self, $c) = @_; $c->req->base(URI->new(IbexFarm->config->{url_prefix})); }; 1' >> /var/ibexfarm/ibexfarm/lib/IbexFarm/Controller/Root.pm

# Fix the id of the apache user and group so we know what they are
# when doing chowns in the host system.
RUN groupmod -g 987654 apache && \
    usermod -u 987654 apache

EXPOSE 80 443
ENTRYPOINT ["/var/ibexfarm/start.sh"]
