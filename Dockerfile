# Use slim Python image
FROM python:3.11-slim

# Install system dependencies + Google Cloud CLI
RUN apt-get update && apt-get install -y \
    git \
    curl \
    gnupg \
    apt-transport-https \
    ca-certificates \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
       > /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
       | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg \
    && apt-get update \
    && apt-get install -y google-cloud-cli \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /dbt

# Copy requirements first for better Docker caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the full dbt project
COPY . .

# Tell dbt where profiles.yml is
ENV DBT_PROFILES_DIR=/dbt

# Default command only; Cloud Run Job can override this
CMD ["dbt", "--version"]