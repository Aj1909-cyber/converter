FROM python:3.10-slim

WORKDIR /app

# Install system dependencies including FFmpeg
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all application files
COPY . .

# Hugging Face Spaces exposes port 7860
ENV PORT=7860
EXPOSE 7860

# Run the Flask app
CMD ["python", "app.py"]
