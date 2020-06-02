FROM zuazo/chef-local:debian-7

RUN git clone https://github.com/miketheman/nginx.git /tmp/nginx
RUN berks vendor -b /tmp/nginx/Berksfile $COOKBOOK_PATH
RUN chef-client -r "recipe[apt],recipe[nginx]"

CMD ["nginx", "-g", "daemon off;"]
