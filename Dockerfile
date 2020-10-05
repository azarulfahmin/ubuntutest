FROM ubuntu:18.04
USER root
WORKDIR /
SHELL ["/bin/bash", "-xo", "pipefail", "-c"]
#ENV http_proxy=http://proxy.jf.intel.com:911
#ENV https_proxy=http://proxy.jf.intel.com:911
#ENV no_proxy=10.221.123.161
# Creating user openvino
RUN useradd -ms /bin/bash openvino && \
    chown openvino -R /home/openvino
ARG DEPENDENCIES="autoconf \
                  automake \
                  build-essential \
                  cmake \
                  cpio \
                  curl \
                  gnupg2 \
                  libdrm2 \
                  libglib2.0-0 \
                  lsb-release \
                  libgtk-3-0 \
                  libtool \
                  udev \
                  unzip \
                  dos2unix"
RUN apt-get update && \
    apt-get install -y --no-install-recommends ${DEPENDENCIES} && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /thirdparty
RUN sed -Ei 's/# deb-src /deb-src /' /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y install sudo && \
    apt-get source ${DEPENDENCIES} && \
    rm -rf /var/lib/apt/lists/*
# setup Python
ENV PYTHON python3.6
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3-pip python3-dev && \
    rm -rf /var/lib/apt/lists/*
# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["/bin/bash"]
