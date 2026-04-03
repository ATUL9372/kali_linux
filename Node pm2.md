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

✅ 7. Re-save (important after startup)
```bash
pm2 save
```

✅ 8. Reboot server 
```bash
sudo reboot
```

✅ 9. Test pm2 working
```bash
pm2 list
```
