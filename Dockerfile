FROM python:3.9-slim

# Устанавливаем DNS-серверы (фикс ошибки "Temporary failure in name resolution")
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf && \
    echo "nameserver 1.1.1.1" >> /etc/resolv.conf

# Создаём пользователя
RUN groupadd -g 1000 appuser && \
    useradd -u 1000 -g appuser -m appuser && \
    mkdir -p /app && \
    chown -R appuser:appuser /app

WORKDIR /app

# Копируем зависимости
COPY requirements.txt .

# Устанавливаем пакеты (с явным указанием DNS уже внутри контейнера)
RUN pip install --no-cache-dir -r requirements.txt

# Копируем остальной код
COPY . .

USER appuser

CMD ["python", "newfile.py"]   # или как у вас называется главный файл
