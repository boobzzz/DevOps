#!/bin/bash

# Зупиняємо виконання скрипта у разі помилки
set -e

echo "🚀 Початок перевірки та встановлення інструментів..."

# Оновлюємо список пакетів (без виводу зайвої інформації)
sudo apt-get update -qq

# ==========================================
# 1. Перевірка та встановлення Docker
# ==========================================
if command -v docker &> /dev/null; then
    echo "✅ Docker вже встановлено: $(docker --version)"
else
    echo "⏳ Встановлення Docker..."
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "✅ Docker успішно встановлено."
fi

# ==========================================
# 2. Перевірка та встановлення Docker Compose
# ==========================================
# Перевіряємо як стару версію (docker-compose), так і нову (docker compose)
if command -v docker-compose &> /dev/null || docker compose version &> /dev/null; then
    echo "✅ Docker Compose вже встановлено."
else
    echo "⏳ Встановлення Docker Compose..."
    sudo apt-get install -y docker-compose
    echo "✅ Docker Compose успішно встановлено."
fi

# ==========================================
# 3. Перевірка та встановлення Python 3 (>= 3.9) та pip
# ==========================================
if command -v python3 &> /dev/null && command -v pip3 &> /dev/null; then
    echo "✅ Python вже встановлено: $(python3 --version)"
else
    echo "⏳ Встановлення Python 3 та pip..."
    sudo apt-get install -y python3 python3-pip
    echo "✅ Python та pip успішно встановлено."
fi

# ==========================================
# 4. Перевірка та встановлення Django через pip
# ==========================================
if python3 -c "import django" &> /dev/null; then
    echo "✅ Django вже встановлено: $(python3 -m django --version)"
else
    echo "⏳ Встановлення Django через pip..."
    # Встановлюємо Django. Прапорець --break-system-packages може знадобитися
    # на нових версіях Ubuntu (23.04+) через PEP 668, тому додаємо фолбек.
    pip3 install Django || pip3 install --break-system-packages Django
    echo "✅ Django успішно встановлено."
fi

echo "🎉 Всі інструменти успішно перевірені та налаштовані!"