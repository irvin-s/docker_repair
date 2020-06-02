FROM berlius/artificial-intelligence-gpu

MAINTAINER berlius <berlius52@yahoo.com>

# upgrade dependencies
RUN pip install --upgrade matplotlib \
                          ipykernel 
                          
# cloning the repository                          
RUN git clone https://github.com/btaba/intro-to-rl && \
    cd  intro-to-rl/notebooks
    
RUN rm intro-to-rl/notebooks/chapter2.ipynb
RUN rm intro-to-rl/notebooks/chapter4.ipynb
RUN rm intro-to-rl/notebooks/chapter6.ipynb
RUN rm intro-to-rl/notebooks/chapter7.ipynb
RUN rm intro-to-rl/notebooks/chapter5_racetrack/racetrack.ipynb


COPY install.sh /root
RUN chmod +x /root/install.sh
    
# adapting matplotlib invocation
COPY chapter2.ipynb /root/intro-to-rl/notebooks/chapter2.ipynb 
COPY chapter4.ipynb /root/intro-to-rl/notebooks/chapter4.ipynb 
COPY chapter6.ipynb /root/intro-to-rl/notebooks/chapter6.ipynb 
COPY chapter7.ipynb /root/intro-to-rl/notebooks/chapter7.ipynb 
COPY racetrack.ipynb /root/intro-to-rl/notebooks/chapter5_racetrack/racetrack.ipynb
            
WORKDIR "/root"
CMD ["/bin/bash"]




