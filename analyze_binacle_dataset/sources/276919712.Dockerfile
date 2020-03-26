FROM rubydata/notebooks

USER root

RUN mkdir /rubykaigi2017 \
	&& cd /rubykaigi2017 \
	&& git clone https://github.com/rubydata/rubykaigi2017.git . \
	&& ln -sf /notebooks/examples /rubykaigi2017/pycall-examples \
	&& chown -R $NB_USER.$NB_GID /rubykaigi2017

RUN cd /rubykaigi2017 \
	&& bundle install \
	&& pip install -U -r requirements.txt

USER $NB_USER

RUN ln -sf /rubykaigi2017 $HOME/rubykaigi2017

WORKDIR $HOME/rubykaigi2017
