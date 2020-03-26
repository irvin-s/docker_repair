FROM phusion/baseimage  
  
ENV TERM screen-256color  
ENV LC_ALL en_US.UTF-8  
ENV LC_CTYPE en_US.UTF-8  
ENV HOME /root  
ENV XDG_CONFIG_HOME /root/.config  
  
CMD ["/sbin/my_init"]  
  
# apt-fast  
RUN add-apt-repository --yes ppa:saiarcot895/myppa \  
&& apt-get update \  
&& apt-get -y install apt-fast \  
# apt-get  
&& add-apt-repository --yes ppa:neovim-ppa/stable \  
&& apt-fast update \  
&& apt-fast -y upgrade \  
&& apt-fast -y install \  
bash-completion \  
git \  
neovim \  
python-pip \  
python3-pip \  
tmux \  
wget \  
xsel \  
&& apt-fast clean \  
# setup with dotfile  
&& git clone https://github.com/DuckLL/dotfile.git --depth 1 ~/dotfile \  
&& cd ~/dotfile \  
&& ./linux.sh  

