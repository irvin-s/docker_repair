FROM mzpi/smlsharp
MAINTAINER mzp <mzp@ocaml.jp>
RUN aptitude install -y git
RUN git clone https://github.com/mzp/space_tab_bot
RUN cd space_tab_bot && make
ADD space_tab_bot /root/.space_tab_bot
