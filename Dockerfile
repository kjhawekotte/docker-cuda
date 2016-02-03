FROM ubuntu:14.04
MAINTAINER Keenan Hawekotte <keenan.hawekotte@hudl.com>

# Pre-reqs
RUN sudo apt-get update && sudo apt-get install -y wget build-essential 

# Install CUDA from specific deb
#RUN cd && \
#  wget -q http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb && \
#  sudo dpkg -i cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb && \
#  sudo apt-get update && \
#  sudo apt-get -y install cuda

RUN cd /opt && \
  wget -q http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda_7.5.18_linux.run && \
  chmod +x *.run && \
  mkdir nvidia_installers && \
  ./cuda_7.5.18_linux.run -extract=`pwd`/nvidia_installers && \
  cd nvidia_installers && \
  ./NVIDIA-Linux-x86_64-352.39.run -s -N --no-kernel-module

RUN cd /opt/nvidia_installers && \
  ./cuda-linux64-rel-7.5.18-19867135.run -noprompt && \
  ./cuda-samples-linux-7.5.18-19867135.run -noprompt


# Env vars for CUDA
ENV LIBRARY_PATH=/usr/local/cuda-7.5/lib64:$LD_LIBRARY_PATH
ENV PATH=/usr/local/cuda-7.5/bin:$PATH

# Entry point
RUN cd && cuda-install-samples-7.5.sh .
RUN cd NVIDIA_CUDA-7.5_Samples/1_Utilities/deviceQuery && make
