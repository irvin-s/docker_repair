FROM dimo414/ci-bash  
  
ENV PGEM_TEST='/pgem_test'  
RUN mkdir $PGEM_TEST  
COPY *.sh /pgem_test/  
RUN chmod +x /pgem_test/*.sh  
  
ENV _PGEM_DEBUG true  
  
LABEL \  
version="0.3" \  
description="Image for CI tests of ProfileGem and ProfileGem gems"  
  

