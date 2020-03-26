FROM phusion/baseimage

# add all deb repositories, then apt-get update once
## ruby
RUN apt-get install software-properties-common
RUN apt-add-repository ppa:brightbox/ruby-ng
## update
RUN apt-get update

# shared system-level dependencies
RUN apt-get install -y build-essential

# knife for the knife discoverer
## first, ruby 1.9.3
RUN apt-get install -y ruby1.9.3
## Update rubygems for parallel installation
RUN gem install rubygems-update \
 && update_rubygems \
 && gem update --system
## next, the gems
RUN mkdir /knife
WORKDIR /knife
RUN gem install bundler --no-document
COPY knife/Gemfile /knife/Gemfile
COPY knife/Gemfile.lock /knife/Gemfile.lock
RUN apt-get install -y ruby-dev zlib1g-dev liblzma-dev
RUN bundle install
WORKDIR /root
# end of knife

# aws cli
RUN apt-get install -y awscli

# tmux-cssh
RUN mkdir /tmux-cssh
COPY tmux-cssh/tmux-cssh_1.0.6-0.deb /tmux-cssh/
RUN apt-get install -y tmux \
 && dpkg -i /tmux-cssh/tmux-cssh_1.0.6-0.deb
# end of tmux-cssh

# easyssh static binary and entrypoint
COPY easyssh /easyssh
COPY entrypoint.sh /entrypoint.sh

# Default easyssh configuration
ENV easyssh_executor "(if-command (ssh-exec-parallel) (if-one-target (ssh-login) (tmux-cssh)))"
ENV easyssh_discoverer "(first-matching (knife) (comma-separated))"
ENV easyssh_filter "(list (ec2-instance-id us-east-1) (ec2-instance-id us-west-1))"

# Aaaaand go!
ENTRYPOINT ["/entrypoint.sh"]
