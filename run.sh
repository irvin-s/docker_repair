#!/bin/bash

result=0
# will trap execution if an error is observed during execution
trap 'result=1' ERR

cd keyword_gen;
python3 keyword_creator.py ../logs/fail/196166778.log
cd ../query_proc;
python3 query_process.py 

exit $result
