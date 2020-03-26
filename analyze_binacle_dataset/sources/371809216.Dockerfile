FROM delner/nginx-unicorn-rails:1.10.1-2.3.1

# (Optional) Use gem data volume
# Create via: docker create -v /ruby_gems/2.3.1 --name gems-2.3.1 busybox
# ENV GEM_HOME /ruby_gems/2.3.1
# ENV PATH /ruby_gems/2.3.1/bin:$PATH

# (Optional) Set custom Nginx site configuration (if you have any)
# ADD config/nginx/production.conf /etc/nginx/sites-enabled/default

# (Optional) Set custom Unicorn configuration (if you have any)
# ADD config/unicorn/production.rb config/unicorn.rb

# Automatically start the web server
CMD gem install foreman && \
    bundle install && \
    bundle exec rake assets:precompile && \
    foreman start -f Procfile

EXPOSE 80