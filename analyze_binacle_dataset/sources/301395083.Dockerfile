FROM kubam/base
MAINTAINER vallard@benincosa.com

# allow autoindexing of kubam
ADD kubam/files/default.conf /etc/nginx/conf.d
# turn daemon off of default nginx server.
ADD kubam/files/nginx.conf /etc/nginx/nginx.conf 
# files for scripts to run 
ADD kubam/files/stage1 /usr/share/kubam/stage1
ADD kubam/templates /usr/share/kubam/templates
# add all the Ansible scripts for post install
ADD kubam/ansible /usr/share/kubam/ansible
# get our scripts installed. 
ADD kubam/scripts/* /usr/bin/

ADD kubam/app /app
EXPOSE 80
CMD ["/bin/bash", "/usr/bin/init.sh"]
