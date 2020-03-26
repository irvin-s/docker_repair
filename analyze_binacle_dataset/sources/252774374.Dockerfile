FROM amirandastratio/clibase  
RUN sudo apt-get install -y netcat apt-file procps net-tools lsof && \  
sudo apt-file update  
  
ENTRYPOINT ["bash"]  
CMD ["-c","nc -ls 0.0.0.0 -p $HTTP_PORT"]  

