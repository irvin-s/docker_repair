FROM nakosung/caffe-cpu  
  
RUN wget http://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz  
RUN tar -xvzf ncurses-5.9.tar.gz  
RUN cd ncurses-5.9 && ./configure && make && make install  
  

