FROM dirtsimple/php-server:latest  
  
# Install dependencies  
RUN EXTRA_APKS="imap-dev dovecot" EXTRA_EXTS=imap install-extras  
  
# Install/build Postfixadmin  
ENV CODE_BASE /code  
ENV PHP_CONTROLLER true  
ENV NGINX_OWNED templates_c  
  
ARG POSTFIXADMIN_VERSION=3.1  
RUN git clone \--branch postfixadmin-$POSTFIXADMIN_VERSION \--depth 1 \  
https://github.com/postfixadmin/postfixadmin $CODE_BASE \  
&& mkdir -p $CODE_BASE/templates_c  
  
COPY config.local.php $CODE_BASE/  
  
ENV SMTPHOST mailserver  
ENV DEFAULT_ALIASES "abuse hostmaster postmaster webmaster"  
ENV ADMIN_USER postfixadmin  
ENV ENCRYPTION dovecot:SHA512-CRYPT  
  
WORKDIR $CODE_BASE  
  

