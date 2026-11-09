FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim
WORKDIR /app
COPY pyproject.toml README.md ./
RUN uv sync --no-cache --no-install-project
COPY gsc_server.py .
ENV MCP_TRANSPORT=http MCP_HOST=0.0.0.0 MCP_PORT=3001 GSC_SKIP_OAUTH=true GSC_ALLOW_DESTRUCTIVE=false
EXPOSE 3001
CMD ["sh","-c","printf '%s' \"$GSC_CREDENTIALS_JSON\" > /tmp/sa.json && export GSC_CREDENTIALS_PATH=/tmp/sa.json && exec uv run --no-sync python gsc_server.py"]
