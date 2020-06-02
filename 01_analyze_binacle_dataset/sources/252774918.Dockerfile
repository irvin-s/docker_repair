from python:3.6  
run pip install flask  
  
run mkdir /data  
run mkdir /workspace  
workdir /workspace  
copy dispense/api .  
  
copy dispense/start.sh /start.sh  
cmd FLASK_APP=/workspace/api.py flask run --host=0.0.0.0  

