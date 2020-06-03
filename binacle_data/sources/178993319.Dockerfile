FROM    ruby

# rails dependencies
RUN     apt-get update -qq && apt-get install -y build-essential libpq-dev curl nodejs

# set this up for development as well
RUN     apt-get install -y zsh emacs git nano vim less
RUN     (curl -L http://install.ohmyz.sh | sh) || true
RUN     chsh -s /bin/zsh
RUN     sed -i '$iDISABLE_UPDATE_PROMPT=true' /root/.zshrc
RUN     sed -i '/ZSH_THEME=/c ZSH_THEME="frisk"' /root/.zshrc
# default command when we want to use this for development
CMD     ["/usr/bin/zsh"]

# set up the rails app
RUN     mkdir /app
WORKDIR /app
ADD     Gemfile /app/Gemfile
ADD     Gemfile.lock /app/Gemfile.lock
RUN     bundle install
ADD     startup.sh /opt/startup.sh
EXPOSE  3000
