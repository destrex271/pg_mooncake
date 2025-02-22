FROM postgres:17 AS builder

RUN apt update \
 && apt install -y \
    curl \
    g++ \
    liblz4-dev \
    cmake \
    patchelf \
    postgresql-server-dev-17 \
 && rm -rf /var/lib/apt/lists/*

RUN curl https://sh.rustup.rs | sh -s -- -y

ENV PATH="/root/.cargo/bin:$PATH"

COPY . /tmp/pg_mooncake

RUN cd /tmp/pg_mooncake \
 && make clean-all \
 && make release \
 && DESTDIR=/out make install

FROM postgres:17

RUN apt update \
 && apt install -y ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN echo "shared_preload_libraries = 'pg_mooncake'" >> /usr/share/postgresql/postgresql.conf.sample

COPY --from=builder /out /
