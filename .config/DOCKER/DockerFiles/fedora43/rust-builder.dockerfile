FROM scratch AS builder
ENV DISTTAG=f43container FGC=f43 FBR=f43
ADD fedora-20260426.tar /

RUN dnf install -y rust cargo gcc gcc-c++ && dnf clean all

# Set the working directory to where your plugins will be mounted
WORKDIR /plugins
CMD ["cargo", "build", "--release"]
