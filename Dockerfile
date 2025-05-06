FROM python:3.11-slim

WORKDIR /app

# Install curl and uv
RUN apt-get update && apt-get install -y curl && \
    curl -LsSf https://astral.sh/uv/install.sh | sh

# Add uv-created virtual environment to PATH
ENV PATH="/root/.local/bin:/app/.venv/bin:$PATH"

# Copy project files
COPY . .

# Install dependencies into .venv
RUN uv sync

# Start the FastAPI app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
