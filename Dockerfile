# Use Python 3.12 slim as the base image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies including PortAudio
RUN apt-get update && apt-get install -y \
    portaudio19-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements.txt
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Set environment variables
ENV PORT=8080

# Command to run the application
CMD exec uvicorn main:app --host 0.0.0.0 --port ${PORT}
