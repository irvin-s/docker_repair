FROM scratch  
MAINTAINER Akihiro Uchida <uchida@turbare.net>  
ADD base.txz /  
ADD lib32.txz /  
CMD ["/bin/sh"]  

