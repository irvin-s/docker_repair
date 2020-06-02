# This image will be built when you run ./proof_of_location/setup.sh
# It needs to be run from the 'pepper' directory to get the proper build context.
FROM alpine

RUN mkdir /proof_of_location
COPY bin /proof_of_location/bin

COPY proof_of_location/prove.sh /proof_of_location
COPY proof_of_location/verify.sh /proof_of_location

COPY prover_verifier_shared /proof_of_location/prover_verifier_shared
COPY proving_material /proof_of_location/proving_material
COPY verification_material /proof_of_location/verification_material

WORKDIR /proof_of_location

RUN echo "to generate proof, run './prove.sh'"
RUN echo "to verify proof, run './verify.sh'"
