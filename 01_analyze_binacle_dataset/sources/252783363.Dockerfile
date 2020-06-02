FROM centos:6.6  
MAINTAINER MIRhosting <dev@mirhosting.com>  
  
# bitrix  
ADD http://repos.1c-bitrix.ru/yum/bitrix-env.sh /tmp/  
RUN chmod +x /tmp/bitrix-env.sh  
RUN sed -i 's/read version_c/version_c=5/gi' /tmp/bitrix-env.sh  
RUN /tmp/bitrix-env.sh  
  
EXPOSE 21 22 25 53 80 110 143 443 465 3306  

