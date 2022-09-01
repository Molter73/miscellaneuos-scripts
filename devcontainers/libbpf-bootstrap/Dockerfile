FROM fedora:35

RUN dnf install -y \
    gcc \
    gcc-c++ \
    git \
    make \
    cmake \
    autoconf \
    automake \
    elfutils-libelf-devel \
    zlib-devel \
    clang \
    llvm \
    findutils \
    bpftool \
# Debugging packages
    gdb \
    clang-analyzer && \
# Set some symlinks to allow building of drivers.
    kernel_version=$(uname -r) && \
    ln -s "/host/lib/modules/$kernel_version" "/lib/modules/$kernel_version" && \
    ln -s "/host/usr/src/kernels/$kernel_version" "/usr/src/kernels/$kernel_version"
