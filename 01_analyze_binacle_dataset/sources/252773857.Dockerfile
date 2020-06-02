FROM asciidoctor/docker-asciidoctor  
  
LABEL MAINTAINERS="Alper Yilmaz <alperyilmaz@gmail.com>"  
  
ARG ASCIIDOCTOR_VERSION="1.5.6.1"  
ENV asciidoctor_version=${ASCIIDOCTOR_VERSION}  
  
RUN apk add --no-cache libxslt-dev ruby-dev build-base \  
&& gem install --no-document asciidoctor-bibtex \  
&& gem install --no-document asciidoctor-bibliography \  
&& gem install --no-document bibtex-ruby \  
&& gem install --no-document citeproc-ruby \  
&& gem install --no-document csl-styles \  
&& apk del build-base ruby-dev  
  
WORKDIR /documents  
VOLUME /documents  
  
CMD ["/bin/bash"]  

