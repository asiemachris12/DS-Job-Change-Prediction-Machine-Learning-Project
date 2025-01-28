# Use an official Python base image
FROM python:3.8-slim

# Set a working directory inside the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files 
COPY . /app

# Install JupyterLab (optional but common in data science workflows)
RUN pip install jupyterlab

# Add a non-root user for better security
RUN useradd -ms /bin/bash vscode
USER vscode

# Expose port for JupyterLab
EXPOSE 8888:8888

# Default command
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
