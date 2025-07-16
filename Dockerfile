# Use NVIDIA’s DeepStream development image as base
FROM nvcr.io/nvidia/deepstream:7.1-gc-triton-devel
# Install tools for NGC CLI
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Install NGC CLI
RUN wget -O /usr/local/ngccli_linux.zip https://ngc.nvidia.com/downloads/ngccli_linux.zip && \
    unzip /usr/local/ngccli_linux.zip -d /usr/local && \
    chmod +x /usr/local/ngc-cli/ngc && \
    ln -s /usr/local/ngc-cli/ngc /usr/local/bin/ngc && \
    rm /usr/local/ngccli_linux.zip

# Install Python dependencies
RUN pip3 install --upgrade pip && \
    pip3 install \
      pyds \
      numpy \
      pandas \
      matplotlib \
      ffmpeg-python

# Set working directory
WORKDIR /workspace

# Copy project files into container
COPY . /workspace

# Default command
CMD ["bash"]
