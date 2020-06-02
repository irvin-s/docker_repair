# DOCOMPILER -- image to compile Document Objects  
#  
# contains the DocumentObjectCompiler from  
# > https://github.com/binfalse/DocumentObjectCompiler  
# to generate PDF files from Document Object  
# USAGE:  
# given a Document Object in /tmp/myproject/do.zip:  
#  
# docker run --rm -v /tmp/myproject:/job binfalse/docompiler:1.0 /job/do.zip  
#  
# you'll find a PDF and pdflatex output in /tmp/myproject/  
#  
# based regular DEBIAN TESTING w/ JAVA w/ TEXLIVE-FULL  
FROM binfalse/d-java8-texlive-full:1.0  
# see http://binfalse.de/contact/ if you want to contact me  
MAINTAINER martin scharm  
  
# include the docompiler.jar  
# see https://github.com/binfalse/DocumentObjectCompiler  
COPY docompiler.jar /usr/bin/  
  
# the docompiler is out entry point  
ENTRYPOINT ["java", "-jar", "/usr/bin/docompiler.jar"]  

