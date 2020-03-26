FROM abigbigbird/allcodis  
MAINTAINER zhijie.lv <401379957@qq.com>  
  
RUN chmod a+x /opt/codis/shellfiles/runproxy.sh  
EXPOSE 11000 19000  
CMD ["/opt/codis/shellfiles/runproxy.sh"]  

