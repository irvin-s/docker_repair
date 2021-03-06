FROM ppc64le/r-base
MAINTAINER "Yugandha deshpande <yugandha@us.ibm.com>"

ENV _R_CHECK_FORCE_SUGGESTS_ false
RUN apt-get update \
	&& apt-get install git -y \
	&& git clone https://github.com/cran/dichromat.git \
	&& cd dichromat && git checkout 2.0-0 \
	&& cd .. \
	&& R CMD build dichromat \
	&& R CMD INSTALL dichromat \
	&& R CMD check dichromat --no-manual \
	&& apt-get purge --auto-remove git -y

CMD ["/bin/bash"]
