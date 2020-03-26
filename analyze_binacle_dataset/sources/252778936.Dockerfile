FROM alpine  
  
RUN apk --no-cache add git git-daemon  
  
USER daemon  
  
VOLUME /srv/git  
  
EXPOSE 9418  
ENTRYPOINT ["git"]  
  
CMD ["daemon", "--reuseaddr", "--base-path=/srv/git/", "/srv/git/"]  

