FROM casimir/blinux:latest  
MAINTAINER Martin Chaine <chaine_a@epitech.eu>  
  
RUN useradd -md /home/bill bill  
USER bill  
  
WORKDIR /home/bill/workspace  
ADD make_and_test.sh /home/bill/make_and_test.sh  
ADD norme_deepthought.py /home/bill/norme_deepthought.py  
ENTRYPOINT exec /home/bill/make_and_test.sh  

