FROM perl:5.20  
RUN mkdir /var/www && chown -R www-data:www-data /var/www  
COPY nph-proxy.cgi /var/www  
WORKDIR /var/www  
RUN ./nph-proxy.cgi init && cpan FCGI && cpan FCGI::ProcManager  
EXPOSE 8002  
CMD [ "./nph-proxy.cgi", "start-fcgi" ]  
  

