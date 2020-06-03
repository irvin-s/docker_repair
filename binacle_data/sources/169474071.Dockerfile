FROM brandonmathis/taperole:latest

# add playbooks to the image. This might be a git repo instead
ADD . /taperole

# We dont have swap access on travis. Chill this role out
RUN truncate -s 0 /taperole/roles/general/tasks/swapfile.yml

# Install Tape
WORKDIR /taperole
RUN gem build taperole.gemspec
RUN gem install slack-notifier
RUN gem install taperole # gem installs from local directory first, then remote

# Configure tape
RUN git clone https://github.com/BrandonMathis/vanilla-rails-app.git
WORKDIR /taperole/vanilla-rails-app
RUN echo 'n' | tape installer install
ADD ./test/rails/tape_vars.yml taperole/tape_vars.yml

# FIXME
# Disable ufw bc docker gets mad about iptables
RUN sed -i '/ufw/d' taperole/provision.yml

# Run Tape
RUN echo '[omnibox]' > taperole/hosts
RUN echo 'localhost ansible_connection=local be_app_env=production be_app_branch=master' >> taperole/hosts
RUN tape ansible provision
RUN chown deployer:users /home/deployer -R
ADD test/rails/start_rails.sh /

# Set command that runs the rails app
WORKDIR /
CMD ["/start_rails.sh"]
