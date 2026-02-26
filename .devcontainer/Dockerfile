FROM python:3.11-slim

# Install system deps
RUN apt-get update && apt-get install -y \
    curl git zsh vim \
    && rm -rf /var/lib/apt/lists/*

# Install LiteLLM proxy + helpers
RUN pip install --no-cache-dir "litellm[proxy]" httpie

# Create workspace and data dirs
RUN mkdir -p /workspace/data/litellm

WORKDIR /workspace
