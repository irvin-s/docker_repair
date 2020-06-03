# ベースイメージの取得  
FROM centos:7  
# 作成者情報  
MAINTAINER ababa  
# Apache HTTP Serverのインストール  
RUN yum -y install httpd  
# Webコンテンツの配置  
ADD html/ /var/www/html/  
# ポートの解放  
EXPOSE 80  
# httpdの実行  
CMD ["/usr/sbin/httpd","-D", "FOREGROUND"]

