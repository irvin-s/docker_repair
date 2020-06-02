FROM	fritzprix/cbuild:0.0.1

MAINTAINER	fritzprix

RUN	apt-get update
RUN	git clone https://github.com/fritzprix/TachyOS.git
WORKDIR	TachyOS
RUN	make config ARCH=ARM DEFCONF=stm32f4_def.conf
CMD	make release & make all


