FROM alpine  
  
RUN apk add --no-cache git  
  
ENV REPO_LOCAL /data/git/repos/demo  
ENV REPO_BRANCH master  
ENV REPO_REMOTE https://github.com/containerize/git  
  
COPY git-entrypoint.sh /usr/local/bin/  
  
ENTRYPOINT [ "git-entrypoint.sh"]  

