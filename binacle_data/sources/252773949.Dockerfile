FROM alexsuch/angular-cli:1.7  
RUN apk --update add git bash openssh  
  
WORKDIR /project  
  
ADD . .  
  
# Tell git to use your `ssh-git.sh` script  
RUN chmod 600 git_ssh_key  
ENV GIT_SSH="/project/ssh-git.sh"  
RUN npm i  
RUN ng build --prod  
  
FROM jonnybgod/alpine-nginx:master  
  
WORKDIR /src  
  
COPY \--from=0 /project/dist/ .  
ADD ./nginx.conf /etc/nginx/nginx.conf  
  
EXPOSE 80 443  
ENTRYPOINT ["nginx"]  

