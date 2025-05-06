FROM python:3.11-slim

WORKDIR /app

# install curl, uv
RUN apt-get update && apt-get install -y curl && \
    curl -LsSf https://astral.sh/uv/install.sh | sh

# copy project
COPY . .

# install dependencies
RUN ~/.cargo/bin/uv sync

# run app
CMD ["~/.cargo/bin/uv", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
