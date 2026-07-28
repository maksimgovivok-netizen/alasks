FROM python:3.9-slim

# Создаём пользователя и папку
RUN groupadd -g 1000 appuser && \
    useradd -u 1000 -g appuser -m appuser && \
    mkdir -p /app && \
    chown -R appuser:appuser /app

WORKDIR /app

# Копируем зависимости
COPY requirements.txt .

# Устанавливаем пакеты (без изменения resolv.conf)
RUN pip install --no-cache-dir --timeout=100 --retries=5 -r requirements.txt

# Копируем остальной код
COPY . .

USER appuser

CMD ["python", "newfile.py"]   # или другой ваш главный файл
