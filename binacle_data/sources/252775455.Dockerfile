FROM debian:experimental  
MAINTAINER Bence SZIGETI <bence.szigeti@gohyda.com>  
  
ENV HOME /root  
  
RUN apt update && apt install --no-install-recommends --yes \  
ca-certificates \  
curl \  
libsasl2-modules \  
locales \  
locales-all \  
mutt \  
neovim  
  
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
RUN mkdir -p ${HOME}/.local/share/nvim/site/spell/  
RUN curl "http://ftp.vim.org/pub/vim/runtime/spell/en.utf-8.spl" \  
-o "${HOME}/.local/share/nvim/site/spell/en.utf-8.spl"  
RUN curl "http://ftp.vim.org/pub/vim/runtime/spell/en.utf-8.sug" \  
-o "${HOME}/.local/share/nvim/site/spell/en.utf-8.sug"  
COPY res/.muttrc ${HOME}  
  
COPY opt/entrypoint.sh /opt  
ENTRYPOINT ["/opt/entrypoint.sh"]  

