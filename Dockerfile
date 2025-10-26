FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    g++ \
    make \
    zlib1g-dev \
    libssl-dev \
    gperf \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Clone and build Telegram Bot API
RUN git clone --recursive https://github.com/tdlib/telegram-bot-api.git /telegram-bot-api && \
    cd /telegram-bot-api && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local .. && \
    cmake --build . --target install && \
    cd / && \
    rm -rf /telegram-bot-api

# Create working directory
RUN mkdir -p /var/lib/telegram-bot-api

# Expose port
EXPOSE 8081

# Start the server
CMD telegram-bot-api \
    --api-id=${TELEGRAM_API_ID} \
    --api-hash=${TELEGRAM_API_HASH} \
    --local \
    --http-port=8081 \
    --dir=/var/lib/telegram-bot-api \
    --verbosity=2
