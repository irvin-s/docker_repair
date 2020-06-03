FROM colstrom/fish  
  
RUN apk-install \  
curl \  
fish \  
git  
RUN adduser \  
-D \  
-u 1000 \  
-s /usr/local/bin/fish \  
nemo  
RUN echo 'nemo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers  
  
USER nemo  
WORKDIR /home/nemo  
  
SHELL ["fish", "-c"]  
  
RUN curl \  
\--location \  
\--silent \  
https://raw.github.com/rafaelrinaldi/pure/master/installer.fish \  
> /tmp/pure_installer.fish  
RUN source /tmp/pure_installer.fish; and install_pure  
  
RUN curl \  
\--location \  
\--output $HOME/.config/fish/functions/fisher.fish \  
\--create-dirs \  
git.io/fisherman  
RUN fisher fishtape .  
  
WORKDIR /home/nemo/.config/fish/functions/theme-pure/  
ENTRYPOINT ["fish", "-c"]  
CMD ["fish"]  

