FROM dkil1972/vim-pathogen:latest  
  
MAINTAINER dkil1972 <dermot.kilroy@invoko.co.uk>  
  
ENV TERM=xterm-256color  
ENV DISABLE=""  
COPY run /usr/local/bin/  
  
#custom .vimrc stub  
RUN mkdir -p /ext && echo " " > /ext/.vimrc  
  
ENTRYPOINT ["sh", "/usr/local/bin/run"]  

