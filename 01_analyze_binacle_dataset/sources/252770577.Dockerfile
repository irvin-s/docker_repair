FROM aeons/elixir-dev:1.6.1  
LABEL maintainer="Bjørn Madsen <bm@aeons.dk>"  
  
RUN apk --no-cache add gcc make libc-dev libgcc  
  
CMD ["/bin/sh"]  

