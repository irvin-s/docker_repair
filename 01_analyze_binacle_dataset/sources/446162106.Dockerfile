# Ubuntu 12.04 (precise) + ZeroVM + Python + sympy
#
# BUILDAS sudo docker build -t zerovm_sympy .
# RUNAS sudo docker -i -t run zerovm_sympy <python file>
#

FROM nlothian/zerovm_python
MAINTAINER Nick Lothian nick.lothian@gmail.com

ADD sympy.tar.gz /opt/zerovm/sympy.tar.gz
RUN gzip -d /opt/zerovm/sympy.tar.gz

ADD testsympy.py /opt/zerovm/testsympy.py

CMD ["@/opt/zerovm/testsympy.py"]
# Note that the order of the images currently appears to matter in ZeroVM (I assume this is a bug)
ENTRYPOINT ["sudo", "-u", "zerovmuser", "zvsh", "--zvm-image", "/opt/zerovm/sympy.tar,/lib/python2.7/sympy", "--zvm-image", "/opt/zerovm/python.tar", "python"]


