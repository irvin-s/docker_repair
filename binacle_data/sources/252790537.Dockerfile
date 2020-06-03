FROM google/shaka-packager:release-v2.0.3  
  
FROM ubuntu:bionic  
COPY --from=0 /shaka_packager/src/out/Release/packager /usr/bin/packager  

