FROM alpine  
  
RUN apk update && apk add --no-cache alpine-sdk  
  
RUN adduser build -D && addgroup build abuild  
  
RUN mkdir -p /var/cache/distfiles  
RUN chmod a+w /var/cache/distfiles  
  
COPY minidlna /minidlna  
  
RUN chown build.build /minidlna -R  
  
RUN adduser minidlna -D  
  
USER build  
  
RUN abuild-keygen -n -a  
  
WORKDIR /minidlna  
  
RUN abuild checksum  
  
RUN abuild -r  
  
FROM alpine  
  
COPY \--from=0 /home/build/packages/x86_64/minidlna-1.2.1-r0.apk /minidlna.apk  
  
RUN apk update && apk add --allow-untrusted /minidlna.apk  
  
COPY cmd.sh /cmd.sh  
  
EXPOSE 8200 1900/udp  
  
CMD ["/cmd.sh"]  

