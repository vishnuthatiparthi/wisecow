# Base image
FROM debian:stable-slim

# Install required packages, strfile included in fortune-mod
RUN apt-get update && apt-get install -y --no-install-recommends \
    cowsay \
    fortune-mod \
    netcat-openbsd \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Create directory for fortunes
RUN mkdir -p /usr/share/games/fortunes

# Add /usr/games to PATH (where cowsay and fortune reside)
ENV PATH="/usr/games:${PATH}"

# Set working directory
WORKDIR /app

# Copy wisecow.sh script
COPY wisecow.sh /app/wisecow.sh

# Copy fortunes folder with your custom file ('custom')
COPY fortunes /usr/share/games/fortunes

# Compile the custom fortune file to enable fortune to read it properly
RUN strfile /usr/share/games/fortunes/custom

# Make wisecow.sh executable
RUN chmod +x /app/wisecow.sh

# Expose server port
EXPOSE 4499

# Entry point command to run wisecow.sh
CMD ["./wisecow.sh"]