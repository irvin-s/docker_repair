FROM avatao/ubuntu:14.04  
  
RUN sudo apt-get -qqy update \  
&& sudo apt-get -qqy install libglib2.0-dev  
  
COPY . /  
  
#Install Unicorn  
RUN cd /home/user/unicorn/unicorn-0.9/ \  
&& ./make.sh gcc && sudo ./make.sh install \  
&& cd /home/user/unicorn/unicorn-0.9/bindings/python/ \  
&& sudo make install \  
&& cd /home/user/capstone/capstone-3.0.4/ \  
&& ./make.sh gcc \  
&& sudo ./make.sh install \  
&& cd /home/user/capstone/capstone-3.0.4/bindings/python/ \  
&& sudo make install \  
&& export LD_LIBRARY_PATH=/home/user/unicorn/unicorn-0.9/:$LD_LIBRARY_PATH \  
&& chown -R user:user /home/user  
  
EXPOSE 2222  
  
USER user  
  
CMD ["/usr/sbin/sshd", "-Df", "/etc/ssh/sshd_config_user"]  

