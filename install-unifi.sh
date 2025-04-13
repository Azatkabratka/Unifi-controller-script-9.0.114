#!/bin/bash

set -e

echo "==== Проверка версии Ubuntu ===="
lsb_release -a

echo "==== Установка необходимых пакетов ===="
sudo apt-get update
sudo apt-get install -y ca-certificates apt-transport-https curl gnupg wget

echo "==== Добавление репозитория UniFi ===="
echo 'deb [ arch=amd64,arm64 ] https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg

echo "==== Установка зависимости libssl1.1 (если требуется) ===="
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb -O libssl1.1.deb
sudo dpkg -i libssl1.1.deb || true  # не прерывать скрипт, если пакет уже установлен

echo "==== Добавление репозитория MongoDB 4.4 ===="
curl -fsSL https://pgp.mongodb.com/server-4.4.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-org-server-4.4-archive-keyring.gpg

echo 'deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-org-server-4.4-archive-keyring.gpg] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

echo "==== Установка MongoDB Server ===="
sudo apt-get update
sudo apt-get install -y mongodb-org-server
sudo systemctl enable mongod
sudo systemctl start mongod

echo "==== Установка UniFi Controller ===="
sudo apt-get update
sudo apt-get install -y unifi

echo "==== Включение и перезапуск службы UniFi ===="
sudo systemctl enable unifi
sudo systemctl restart unifi

echo "==== Установка завершена успешно! ===="
