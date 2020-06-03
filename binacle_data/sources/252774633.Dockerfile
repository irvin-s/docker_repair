FROM bartoszj/swift:3.0-preview-2  
MAINTAINER Bartosz Janda  
  
EXPOSE 8181  
RUN apt-get update && apt-get install --no-install-recommends -y \  
uuid-dev \  
libssl-dev \  
&& rm -rf /var/lib/apt/lists/* \  
&& git clone https://github.com/PerfectlySoft/PerfectTemplate.git \  
&& cd PerfectTemplate \  
&& swift build  
  
CMD ["./PerfectTemplate/.build/debug/PerfectTemplate"]  

