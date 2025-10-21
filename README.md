```markdown
# 🌐 Personal VPN Deployer

Автоматизированный VPN-деплой с WireGuard, DDNS Cloudflare и визуальной панелью статуса.  

## Особенности
- Развёртывание VPN на Google Cloud
- Авто-настройка DDNS через Cloudflare
- Генерация клиентского конфига и QR-кода
- Веб-панель статуса с Bootstrap (тёмная тема)
- GitHub Actions workflow: Deploy / Destroy
- Веб-форма для конфигурации без редактирования файлов

## Быстрый старт
1. Загрузить репозиторий на GitHub
2. Добавить Secrets: GCP_SA_KEY, GCP_PROJECT_ID, CLOUDFLARE_API_TOKEN, CLOUDFLARE_ZONE, CLOUDFLARE_RECORD
3. Запустить workflow Deploy
4. Перейти на веб-панель: GitHub Pages `/public/index.html`
```
