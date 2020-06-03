FROM cpro29a/ddemo_pybase  
  
MAINTAINER Sergey Melekhin <sergey@melekhin.me>  
  
ADD ui /var/www/ui  
ADD web_app.py /var/www/  
  
WORKDIR /var/www  
CMD ["python", "web_app.py"]  
  

