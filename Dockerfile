FROM rust:1.50 as builder
RUN cargo install --git https://github.com/roapi/roapi --branch main --bin roapi-http

FROM debian:buster-slim
RUN apt-get update && apt-get install -y libssl-dev && rm -rf /var/lib/apt/lists/*
COPY test_data /test_data
COPY --from=builder /usr/local/cargo/bin/roapi-http /usr/local/bin/roapi-http

CMD ["roapi-http"]