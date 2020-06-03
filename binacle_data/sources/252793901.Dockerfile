# 1.ベースイメージの取得  
FROM centos:latest  
  
# 2.作成者情報  
MAINTAINER 0.1 asashiho@mail.asa.yokohama  
  
# 3.Apache HTTP Serverのインストール  
RUN yum -y install httpd  
  
# 4.Webコンテンツの配置  
ADD html/ /var/www/html/  
  
# 5.ポートの解放  
EXPOSE 80  
# 6.httpdの実行  
CMD ["/usr/sbin/httpd","-D", "FOREGROUND"]

