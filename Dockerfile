FROM ubuntu:24.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    libtool \
    pkg-config \
    gcc \
    g++ \
    make \
    git \
    wget \
    unzip \
    python3 \
    libsonic-dev \
    libpcaudio-dev \
    ronn \
    ruby-ronn \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /espeak-ng

# Copy the source code
COPY . .

# Build espeak-ng
RUN ./autogen.sh && \
    ./configure --prefix=/usr && \
    make -j$(nproc) && \
    make install

EXPOSE 7496

# Set the default command
CMD ["espeak-ng", "-vro", "-q", "-x", "--sep=﹍", "--ipa", "--show-prosody", "--server-mode"]
