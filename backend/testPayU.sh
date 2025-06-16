#!/usr/bin/env bash
set -e

# 1) Получаем токен
TOKEN=$(curl -s -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"secret123"}' \
  | jq -r .token)

echo "=== Используем токен: $TOKEN ==="

# 2) Инициация платежа в PayU (создаём заказ)
echo "=== POST /payments ==="
curl -s -X POST http://localhost:3000/payments \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "amount": 50,
    "currency": "PLN",
    "description": "TestPayU-Order",
    "extOrderId": "order-'$(date +%s)'",
    "notifyUrl": "https://example.com/webhook"
  }' | jq

