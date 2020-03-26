FROM alpine  
  
ENV PS1 "$(whoami)@blackbox# "  
ENV GPG gpg -v  
ENV GNUPGHOME /gnupg  
  
ENV BLACKBOX_REPOBASE /repo  
WORKDIR $BLACKBOX_REPOBASE  
  
RUN apk add --no-cache make git gnupg1 bash coreutils findutils  
RUN git clone https://github.com/StackExchange/blackbox.git /usr/blackbox \  
&& cd /usr/blackbox \  
&& make manual-install  
  
CMD ["blackbox_list_files"]  

