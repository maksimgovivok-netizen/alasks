FROM python:3.9-slim

RUN groupadd -g 1000 appuser && \
    useradd -u 1000 -g appuser -m appuser && \
    mkdir -p /app && \
    chown -R appuser:appuser /app

WORKDIR /app

COPY requirements.txt .

# Обновим pip и установим зависимости (без проблем с resolv.conf)
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --timeout=100 --retries=5 -r requirements.txt

COPY . .

USER appuser

# Используем JSON-формат для CMD (рекомендуется)
CMD ["python", "newfile.py"]
