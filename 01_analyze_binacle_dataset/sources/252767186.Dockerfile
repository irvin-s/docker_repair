FROM alexanderpeev/j-dev-cgroup-ioalg:latest  
RUN cd /home && \  
git clone https://AlexanderPeev@bitbucket.org/AlexanderPeev/io-alg.git && \  
cd /home/io-alg && \  
git config core.fileMode false && \  
git pull && \  
rm -rf build && \  
mkdir build && \  
mkdir build/io_alg_projekt-2 && \  
chmod 777 build  
RUN cd /home/io-alg/build && \  
cmake --target 'io_alg_projekt-2' ../  
RUN cd /home/io-alg/build && \  
make  
RUN /home/io-alg/projekt-2/run/io_alg_projekt-2 test  
CMD /bin/bash  

