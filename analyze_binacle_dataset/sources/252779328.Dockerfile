  
FROM gentoo/stage3-amd64-hardened  
  
RUN mkdir /usr/portage; \  
emerge-webrsync; \  
emerge dev-util/catalyst; \  
rm -rf `ls -1A | grep -vP '^profiles'`  

