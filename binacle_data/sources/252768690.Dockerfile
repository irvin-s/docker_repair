FROM alpine  
  
RUN apk add --update \  
curl \  
netcat-openbsd \  
zsh \  
vim \  
openssl \  
ca-certificates \  
git \  
git-zsh-completion && \  
update-ca-certificates && \  
rm -rf /var/cache/apk/*  
  
COPY .zshrc usage.txt /root/  
COPY _curl /usr/share/zsh/5.2/functions/Completion/Base/  
  
#set zsh as default shell  
ENV SHELL=/bin/zsh  
  
WORKDIR /root  
  
CMD ["/bin/zsh"]

