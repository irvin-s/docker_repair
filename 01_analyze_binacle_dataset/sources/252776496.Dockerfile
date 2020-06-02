FROM perl:5.20  
RUN curl -L http://cpanmin.us | perl - --self-upgrade  
RUN cpanm LWP::UserAgent  
RUN cpanm URI::Find::UTF8  
RUN cpanm LWP::Protocol::https  
COPY url_checker.pl /root/.  
CMD ["/root/url_checker.pl"]  

