# ベースイメージの設定  
FROM ubuntu:17.10  
  
# Nginxのインストール  
RUN apt-get -y update && apt-get -y upgrade  
RUN apt-get -y install nginx  
  
# ポート指定  
EXPOSE 80  
  
# Webコンテンツの配置  
ADD website.tar /var/www/html/  
  
# Nginxの実行  
CMD ["nginx", "-g", "daemon off;"]  

