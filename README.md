# How to use this
```
cd ~/Documents
git clone https://github.com/khangnm1340/pams_cachyOS.git
./pams_cachyOS/pre_reproduce.sh
```

# Optional

## Setting up github
```
git config --global user.email "you@example.com"
git config --global user.name "Your Name"

ssh-keygen -t ed25519 -C "your_email@example.com"
```

### Add the public key to your Git provider
```
cat ~/.ssh/id_ed25519.pub
```

## Setting the password manager

### On your old machine
```
gpg --export -a "your-email@example.com" > public.key
gpg --export-secret-keys -a "your-email@example.com" > private.key
```

### On you new machine
```
gpg --import public.key
gpg --import private.key
pg --edit-key "your-email@example.com"
```
### Inside the GPG prompt:
```
gpg> trust
```
Select '5' (I trust ultimately)
Confirm with 'y', then type 'quit'

### Clone the password store

```
git clone https://github.com/your-username/your-pass-repo.git ~/.password-store
pass git remote add origin git@github.com:your-username/your-pass-repo.git
```
