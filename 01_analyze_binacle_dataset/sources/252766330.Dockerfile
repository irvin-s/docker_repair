FROM abigbigbird/allcodis  
MAINTAINER zhijie.lv <401379957@qq.com>  
  
RUN chmod a+x /opt/codis/shellfiles/rundashboard.sh  
  
EXPOSE 18087  
CMD ["/opt/codis/shellfiles/rundashboard.sh"]  

