FROM fedora:36

ENV RUSTUP_HOME=/usr/local/rustup
ENV CARGO_HOME=/usr/local/cargo
ENV PATH=/usr/local/cargo/bin:$PATH

RUN dnf -y update && \
	dnf -y install \
		gcc \
		openssl \
		openssl-devel \
		perl-File-Compare \
		perl-FindBin \
		bpftool \
		llvm \
		clang

RUN curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | \
	sh -s -- -y --no-modify-path && \
	chmod -R a+w $RUSTUP_HOME $CARGO_HOME && \
	rustup install stable && \
	rustup toolchain install nightly --component rust-src && \
	cargo install bpf-linker
