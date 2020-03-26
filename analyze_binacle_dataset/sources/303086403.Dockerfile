FROM fedora

RUN dnf install -y python-pip git vim gcc make patch ipython yum-utils hardening-check cpio findutils

RUN pip install redteam && \
    pip install python-magic

RUN cd /root && git clone https://github.com/radare/radare2.git

RUN cd /root/radare2 && git checkout 2.0.1 && ./sys/install.sh

RUN pip install r2pipe timeout-decorator

RUN mkdir /fedora_swap
