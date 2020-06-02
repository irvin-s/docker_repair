FROM circleci/node:stretch

RUN sudo apt-get install pandoc -y
RUN sudo apt-get install texlive-latex-base
