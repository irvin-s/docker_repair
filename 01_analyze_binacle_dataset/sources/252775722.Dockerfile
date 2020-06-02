FROM scratch  
LABEL org.label-schema.vendor="Blitznote" \  
org.label-schema.build-date="2017-11-13T20:10:00+00:00" \  
org.label-schema.name="Ubuntu without apt" \  
org.label-schema.vcs-type="git" \  
org.label-schema.vcs-url="https://github.com/Blitznote/baseimage"  
  
ADD rootfs.tar /  
CMD ["/bin/bash"]  
SHELL ["/bin/bash", "-c"]  

