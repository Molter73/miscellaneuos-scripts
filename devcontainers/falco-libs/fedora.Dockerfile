FROM fedora:36

RUN dnf install -y \
    gcc \
    gcc-c++ \
    libasan \
    dnf-plugins-core \
    git \
    make \
    cmake \
    autoconf \
    automake \
    pkg-config \
    patch \
    ncurses-devel \
    libtool \
    elfutils-libelf-devel \
    diffutils \
    which \
    perl-core \
    clang \
    kmod \
# Debugging packages
    gdb \
    clang-analyzer \
# Dependencies needed to build falcosecurity/libs.
    libb64-devel \
    c-ares-devel \
    libcurl \
    libcurl-devel \
    grpc-cpp \
    grpc-devel \
    grpc-plugins \
    jq-devel \
    jsoncpp-devel \
    openssl-devel \
    tbb-devel \
    zlib-devel && \
# Set some symlinks to allow building of drivers.
    kernel_version=$(uname -r) && \
    ln -s "/host/lib/modules/$kernel_version" "/lib/modules/$kernel_version" && \
    ln -s "/host/usr/src/kernels/$kernel_version" "/usr/src/kernels/$kernel_version"

# Install docker CLI
RUN dnf config-manager --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo && \
    dnf install -y docker-ce-cli
