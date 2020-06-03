FROM ruby:2.3.0  
ENV HOME /root  
  
RUN mkdir -p /azk/deploy  
WORKDIR /azk/deploy/src  
  
# install deps  
RUN apt-get update -qq && \  
apt-get install -y -qq ruby-dev make ssh zsh nano vim && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# install oh-my-zsh  
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \  
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc && \  
sed -i "s/^plugins\=\\(.*\\)/teste\=\\(git capistrano\\)/" ~/.zshrc && \  
chsh -s /bin/zsh  
  
# install capistrano  
RUN gem install --no-rdoc --no-ri capistrano -v 3.4.0  
  
COPY *.sh ./  
  
CMD ['/bin/bash']  
  
# ENTRYPOINT ["/azk/deploy/deploy.sh"]  
# CMD ["/azk/deploy/deploy.sh"]  

