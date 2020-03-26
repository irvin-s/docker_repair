FROM berlius/artificial-intelligence-gpu

MAINTAINER berlius <berlius52@yahoo.com>

# Install some dependencies
RUN sudo add-apt-repository -y ppa:hvr/ghc
RUN sudo apt-get update
RUN sudo apt-get install -y cabal-install-1.22 ghc-7.10.3

# Updating environment variables
ENV PATH=~/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH

# Install Euterpea
RUN cabal update
RUN cabal install Euterpea

RUN git clone https://github.com/Euterpea/HSoM; \
                          cd HSoM; \
                          cabal install; \
                          cd .. 
                          

# Install Kulitta
RUN git clone https://github.com/donya/Kulitta && \
                        cd Kulitta && \
                        cabal install 
                        
RUN git clone https://github.com/donya/KulittaCompositions

# Install PythonKulitta
RUN git clone https://github.com/donya/PythonKulitta && \
                              cd PythonKulitta && \
                              git clone https://github.com/vishnubob/python-midi && \
                              cd python-midi && \
                              python setup.py install && \
                              cd .. 
                                              
                     
WORKDIR "/root/sharedfolder"
CMD ["/bin/bash"]




