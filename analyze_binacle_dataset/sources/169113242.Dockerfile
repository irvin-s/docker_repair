FROM nacyot/julia-julia:apt

RUN \
  apt-get update &&\
  apt-get install -y libzmq3 libzmq3-dev python3 python3-pip libmagickwand-dev &&\
  pip3 install ipython==1.1.0 jinja2 tornado pyzmq &&\
  rm /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python &&\
  ln -s /usr/local/bin/ipython3 /usr/local/bin/ipython

RUN julia --eval 'Pkg.add("IJulia"); Pkg.add("PyPlot"); Pkg.update()'

VOLUME /root/notebooks
EXPOSE 8888
CMD ipython notebook --profile julia --ip=0.0.0.0 --notebook-dir=/root/notebooks --port 8888
