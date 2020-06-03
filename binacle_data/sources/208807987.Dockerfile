FROM yaktor/node:0.39.0

RUN echo 'PS1="\u@\h:\w$ "' >> ~/.bash_profile
RUN echo '. ~/.profile' >> ~/.bash_profile

CMD ["tail -f /dev/null"]
