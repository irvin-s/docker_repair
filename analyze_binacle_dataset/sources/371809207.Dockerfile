FROM delner/nginx-unicorn-rails:1.10.1-2.3.1

# (Optional) Use gem data volume
# Created from: docker create -v /ruby_gems/2.3.1 --name gems-2.3.1 busybox
# ENV GEM_HOME /ruby_gems/2.3.1
# ENV PATH /ruby_gems/2.3.1/bin:$PATH

# Set Nginx site configuration
ADD config/nginx/development.conf /etc/nginx/sites-enabled/default

# Automatically start the web server
CMD ./script/start.sh

EXPOSE 80