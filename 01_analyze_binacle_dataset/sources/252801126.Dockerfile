FROM debian:latest  
MAINTAINER DreamerKing <dreamingking@live.cn>  
RUN apt-get update && apt-get install -y cowsay fortune  
COPY entrypoint.sh /  
ENTRYPOINT ["/entrypoint.sh"]  

