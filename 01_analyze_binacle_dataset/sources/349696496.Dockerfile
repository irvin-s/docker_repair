# Image: abacosamples/sum_reducer
# Test image that reduces dictionaries via sum; persists intermediate results via the /state API.

# NOTE: This actor is not stateless.

from abacosamples/base
ADD reducer.py /reducer.py

CMD ["python", "/reducer.py"]