# Description:  
#  
# Python script to fix/add haxe imports and package statements.  
# Usage:  
# docker run --rm -ti -v $PWD:/haxe dionjwa/haxe-imports  
#  
FROM python:2.7.14-alpine3.6  
MAINTAINER dion@transition9.com  
  
WORKDIR /haxe  
ADD haxe_imports_fix.py /src/haxe_imports_fix.py  
ENTRYPOINT ["python2", "/src/haxe_imports_fix.py"]  

