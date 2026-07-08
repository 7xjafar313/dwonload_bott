FROM python:3.10-slim

# Install system dependencies (FFmpeg is required for yt-dlp)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose port (Render sets PORT environment variable, we will run a dummy server on it)
EXPOSE 8000

# Start command
CMD ["python", "bot.py"]
