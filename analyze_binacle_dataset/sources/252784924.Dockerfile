FROM jekyll/jekyll:stable  
  
LABEL MAINTAINER="codeontap"  
  
RUN apk update \  
&& apk upgrade \  
&& apk add bash \  
&& apk add jq  
  
ENV OUTPUT=site  
  
RUN mkdir /indir  
RUN mkdir /outdir  
  
RUN chmod ugo+rwx /indir  
RUN chmod ugo+rwx /outdir  
  
RUN mkdir /srv/jekyll/blueprints  
RUN mkdir /srv/jekyll/_site  
  
VOLUME /outdir  
VOLUME /indir  
  
COPY ./src /srv/jekyll  
COPY ./scripts/build-infradocs.sh /tmp/build-infradocs.sh  
COPY ./scripts/nav_template.json /tmp/nav_template.json  
  
EXPOSE 4000  
CMD ["bash", "/tmp/build-infradocs.sh"]  

