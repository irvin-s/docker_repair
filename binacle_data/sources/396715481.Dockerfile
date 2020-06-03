FROM centos

RUN yum install -y sudo git vim zsh

USER root
# RUN useradd docker
# RUN echo "docker:docker" | chpasswd
RUN useradd homepage
# RUN useradd -m -s /bin/bash homepage
# RUN echo "homepage:" | chpasswd

USER homepage
WORKDIR /home/homepage
RUN git clone https://kazuph@github.com/kazuph/dotfiles.git
RUN su - homepage -lc /home/homepage/dotfiles/update_submodules.sh
RUN cp ~/dotfiles/.zshrc ~/.zshrc
ENTRYPOINT ["/bin/zsh"]
