✅ 1. Install PM2 globally
```bash
npm install -g pm2
```

✅ 2. Verify installation
```bash
pm2 -v
```

✅ 3. pm2 list
```bash
pm2 list
```

✅ 4. pm2 setup 
```bash
pm2 start npm --name "my-app" -- run dev -- --host
```

✅ 5. Save current running app
```bash
pm2 save
```

✅ 6. Enable startup service (MOST IMPORTANT)
```bash
pm2 startup
```

✅ 7. After run pm2 startup command run below command start with sudo env PATH=xxxxx something
```bash
sudo env PATH=$PATH:/home/xxxx/.nvm/xxx/xxx/xxx/xxx/xxxx/xxxx/
```

✅ 8. Re-save (important after startup)
```bash
pm2 save
```

✅ 9. Reboot server 
```bash
sudo reboot
```

✅ 10. Test pm2 working
```bash
pm2 list
```
