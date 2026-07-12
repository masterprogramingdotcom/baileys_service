# Use the official Bun image since this is a Bun-native project
FROM oven/bun:alpine

# Install git so we can clone the source code
RUN apk update && apk add --no-cache git

# Set the working directory inside the container
WORKDIR /app

# Clone the actual Baileys API repository into the container's working directory
RUN git clone https://github.com/fazer-ai/baileys-api.git .

# Install the project dependencies using Bun natively
RUN bun install

# Expose the port the app runs on
EXPOSE 3025

# Command to run the application using Bun natively
CMD ["bun", "src/index.ts"]
