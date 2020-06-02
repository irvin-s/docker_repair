FROM ubuntu:latest  
  
RUN apt-get update  
RUN apt-get install -y \  
git \  
emacs \  
stow  
  
RUN useradd -ms /bin/bash dev  
ENV home /home/dev  
  
USER dev  
  
RUN cd $home \  
&& git clone https://github.com/ActualAdam/dotfiles.git \  
&& stow -d $home/dotfiles bash vi emacs  
  
CMD "/bin/bash; cd ~"  

