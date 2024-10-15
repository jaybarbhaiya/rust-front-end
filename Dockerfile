FROM ubuntu:latest

RUN apt-get update && apt-get install build-essential curl pkg-config openssl openssl -y

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal -y
ENV PATH="/root/.cargo/bin:$PATH"

# Install wasm32 target and trunk
RUN /root/.cargo/bin/rustup target add wasm32-unknown-unknown
RUN /root/.cargo/bin/cargo install trunk

# Copy project files
COPY src .
COPY Cargo.lock .
COPY Cargo.toml .
COPY index.html .
COPY style.css .

CMD ["/root/.cargo/bin/trunk", "serve"]
