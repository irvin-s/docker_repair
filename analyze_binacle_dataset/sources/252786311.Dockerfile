FROM node:8-slim  
  
RUN useradd --create-home app \  
&& apt-get update \  
&& apt-get install -y --no-install-recommends \  
jq \  
git  
WORKDIR /home/app  
ARG WIKI_PACKAGE=wiki@0.14.0  
RUN su app -c "npm install -g --prefix . $WIKI_PACKAGE"  
RUN su app -c "mkdir .wiki"  
COPY configure-wiki set-owner-name ./  
RUN chown app configure-wiki set-owner-name  
VOLUME "/home/app/.wiki"  
ENV DOMAIN=localhost  
ENV OWNER_NAME="The Owner"  
ENV COOKIE=insecure  
EXPOSE 3000  
USER app  
CMD ["/home/app/bin/wiki"]  

