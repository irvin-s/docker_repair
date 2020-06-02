FROM azukiapp/elixir:1.3  
# install postgresql client and build-base  
RUN apk add --update \  
bash \  
ncurses \  
git \  
curl \  
openssh \  
sshpass \  
openssl \  
build-base \  
imagemagick \  
postgresql-client \  
&& mix local.hex --force \  
&& rm -rf /var/cache/apk/* /var/tmp/*  
  
CMD ["iex"]  

