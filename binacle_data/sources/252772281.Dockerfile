FROM perl  
RUN cpanm -v Perl::Tidy  
ENTRYPOINT ["perltidy"]  

