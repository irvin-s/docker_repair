FROM debian:latest  
  
MAINTAINER Steve Müller "st.mueller@dzh-online.de"  
  
ADD ./build /tmp/build  
  
RUN /tmp/build/build.sh 5.5.9 lib/x86_64-linux-gnu  

