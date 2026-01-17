FROM ubuntu:24.04 AS builder

RUN apt-get update && apt-get install -y \
    make git zlib1g-dev libssl-dev gperf cmake \
    clang-18 libc++-18-dev libc++abi-18-dev

RUN git clone --recursive https://github.com/tdlib/telegram-bot-api.git

WORKDIR /telegram-bot-api/build

RUN CXXFLAGS="-stdlib=libc++" CC=/usr/bin/clang-18 CXX=/usr/bin/clang++-18 cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=.. ..
RUN cmake --build . --target install --parallel $(nproc)


FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    libc++-18-dev openssl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN mkdir -p /app/api_data

COPY --from=builder /telegram-bot-api/bin/telegram-bot-api /usr/local/bin/telegram-bot-api

EXPOSE 8081
EXPOSE 8082

ENTRYPOINT ["/usr/local/bin/telegram-bot-api", "--dir=/app/api_data", "--local", "--http-stat-port=8082"]

