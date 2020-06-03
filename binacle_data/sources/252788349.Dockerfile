FROM gdoteof/ghc:7.8.3  
RUN cabal update  
  
RUN apt-get update && apt-get install -y \  
xvfb \  
libgtk2.0 \  
x11vnc \  
ratpoison \  
recordmydesktop \  
git  
  
ADD sublime-text_build-3065_amd64.deb sublime-text.deb  
RUN dpkg -i sublime-text.deb  
RUN rm sublime-text.deb  
  
ADD *.sh /  
RUN chmod +x *.sh  
  
VOLUME /Logs  
  
# Expose vnc port  
EXPOSE 5900  
RUN mkdir -p "$HOME/.config/sublime-text-3/Packages"  
VOLUME /SublimeGHCi  
RUN ln -s /SublimeGHCi "$HOME/.config/sublime-text-3/Packages/SublimeGHCi"  
  
ENV SUBLIME_PATH subl  
ENV DISPLAY :0  

