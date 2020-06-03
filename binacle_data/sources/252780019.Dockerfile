  
FROM php:5.6-apache  
MAINTAINER Viktor Bodrogi <viktor@axonnet.hu>  
  
## Ubuntu  
RUN apt-get update  
RUN apt-get install -y git  
  
## Source  
### Configure  
EXPOSE 80  
ENV Platform /usr/local/src/Platform  
  
ENV DW /var/www/html  
ENV Data $DW/data  
ENV Conf $DW/conf  
  
#RUN sh configure.sh  
### Local  
COPY .git /tmp/Platform.git  
RUN git clone \--recursive /tmp/Platform.git $Platform  
RUN cd $Platform && git status && git submodule status  
  
### DokuWiki & Plugins  
# Copy DokuWiki files  
RUN cp -a $Platform/dokuwiki/* $DW/  
RUN cp -a $Platform/dokuwiki-plugins/lib/plugins/* $DW/lib/plugins/  
  
# Bug: on cloud the submodules are not checked out?  
#COPY LICENSE README.md $DW/  
#COPY dokuwiki/ $DW/  
#COPY dokuwiki-plugins/lib/plugins/ $DW/lib/plugins/  
### DW Cleanup  
RUN rm $DW/composer.* $DW/COPYING $DW/README  
  
### Conf  
#ADD conf/local.php.dist $Conf/local.php  
#ADD conf/htacess.dist $DW/local.php  
#RUN rm $DW/install.php  
RUN chown www-data $Conf  
  
### Data  
RUN chown www-data $Data $Data/*  
RUN chown www-data -R $Data/*/wiki  
  
# Cleanup pages  
RUN rm -fr -R $Data/pages/wiki  
  
## Final DW  
### Status  
RUN cd $Platform && git status && git submodule status  
RUN ls -l $DW/  
  
# CMD pwd && ls -l && ls -la /tmp  
# CMD pwd && apache2-foreground  
## =======  
# Bug: on cloud the submodules are not checked out?  
#COPY LICENSE README.md $Html/  
#COPY dokuwiki/ $Html/  
#COPY dokuwiki-plugins/lib/plugins/ $Html/lib/plugins/  
# Copy DokuWiki files  
RUN cp -a $Platform/dokuwiki/* $Html/  
RUN ls -l $Html/  
RUN cp -a $Platform/dokuwiki-plugins/lib/plugins/* $Html/lib/plugins/  
  
RUN chown www-data \  
$Html/conf \  
$Html/data \  
$Html/data/*  
RUN chown www-data -R $Html/data/*/wiki  
  
# CMD ls -l && ls -l /tmp && apache2-foreground  
## >>>>>>> Platform/merge-0.1.1  

