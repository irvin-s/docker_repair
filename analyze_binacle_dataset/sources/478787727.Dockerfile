FROM archlinux/base

RUN pacman -Syyu --noconfirm
RUN pacman -S gcc --noconfirm
RUN pacman -S rust --noconfirm
RUN pacman -S git --noconfirm
RUN pacman -S make --noconfirm

WORKDIR /home/docker
RUN git clone https://github.com/yurug/pcomp-2019.git
WORKDIR /home/docker/pcomp-2019/
RUN git checkout aquamen/master
RUN git pull
WORKDIR /home/docker/pcomp-2019/defis/1/aquamen
RUN BENCH=0 DEBUG=0 make build

