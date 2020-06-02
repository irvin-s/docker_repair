FROM alpine:edge  
  
RUN apk --update add \  
ruby && \  
gem install --no-ri --no-rdoc kitty && \  
rm -fr /usr/share/ri  
  
ENTRYPOINT ["kitty","-c"]  
CMD ["1"]  

