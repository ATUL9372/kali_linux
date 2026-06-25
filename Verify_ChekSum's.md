# ✅ Syntax for verifying with echo

### Method_1
```bash
  echo "<hash>  <filename>" | shasum -a 256 --check
```

### Method_2
```bash
  echo "<hash> <filename>" | sha256sum -c
```
