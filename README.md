# UniFi Controller Auto-Installer

📦 Bash-скрипт для автоматической установки UniFi Controller на Ubuntu (тестировалось на 20.04 / 22.04).  
Устанавливает MongoDB 4.4, необходимые зависимости и запускает UniFi как службу.

## 🔧 Что делает скрипт

- Проверяет версию Ubuntu
- Добавляет репозитории UniFi и MongoDB
- Устанавливает `libssl1.1`, MongoDB и UniFi Controller
- Включает и запускает службы `mongod` и `unifi`

## 🚀 Быстрый старт

1. Скачай скрипт:

```bash
git clone https://github.com/твой-юзернейм/unifi-installer.git
cd unifi-installer
