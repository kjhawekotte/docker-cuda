FROM ubuntu:14.04
MAINTAINER Keenan Hawekotte <keenan.hawekotte@hudl.com>

# Pre-reqs
RUN sudo apt-get update && sudo apt-get install -y wget build-essential 

# Install CUDA from specific deb
RUN cd && wget http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb && sudo dpkg -i cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb && sudo apt-get update && sudo apt-get -y install cuda

# Env vars for CUDA
ENV LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-6.5/lib64
ENV PATH=$PATH:/usr/local/cuda-6.5/bin

# Entry point
RUN cd && cuda-install-samples-7.5.sh .
RUN cd NVIDIA_CUDA-7.5_Samples/1_Utilities/deviceQuery && make
