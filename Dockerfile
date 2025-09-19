# Use Debian stable-slim as base image
FROM debian:stable-slim

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    cowsay \
    fortune-mod \
    netcat-openbsd \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Create the fortune directory to avoid copy errors
RUN mkdir -p /usr/share/games/fortunes

# Add /usr/games to PATH so cowsay and fortune commands can be found
ENV PATH="/usr/games:${PATH}"

# Set working directory
WORKDIR /app

# Copy wisecow.sh script
COPY wisecow.sh /app/wisecow.sh

# Copy your custom fortune files folder into container
COPY fortunes /usr/share/games/fortunes

# Make wisecow.sh executable
RUN chmod +x /app/wisecow.sh

# Expose the port used by wisecow.sh
EXPOSE 4499

# Run wisecow.sh script on container start
CMD ["./wisecow.sh"]

