from python:slim  
  
run set -ex; \  
pip install --no-cache-dir awscli;\  
apt-get update && apt-get install -y --no-install-recommends \  
zip && rm -rf /var/lib/apt/lists/* ;\  
find /usr/local -depth \  
\\( \  
\\( -type d -a \\( -name test -o -name tests \\) \\) \  
-o \  
\\( -type f -a \\( -name '*.pyc' -o -name '*.pyo' \\) \\) \  
\\) -exec rm -rf '{}' +;  
  

