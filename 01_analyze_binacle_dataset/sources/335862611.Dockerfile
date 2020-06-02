FROM amazonlinux

RUN yum install -y vi git gcc zip wget libssl-dev zlib-devel bzip2 \
        bzip2-devel readline-devel sqlite sqlite-devel openssl-devel

RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py

RUN curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
ADD .bash_profile /root/
RUN source ~/.bash_profile
ENV PATH="/root/.pyenv/bin:$PATH"

RUN pyenv install 3.6.1

RUN mkdir /root/work
WORKDIR /root/work

RUN pyenv local 3.6.1
ADD lambda_function.py .
# RUN source ~/.bash_profile && pip install ethereum web3 -t .
RUN source ~/.bash_profile && pip install 'web3<4.4.0' -t .
RUN zip -r upload.zip *
