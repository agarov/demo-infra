# demo-infra

Live demo repository for a Ruby on Rails deployment workshop.  
Covers the full path from cloud instance creation to a publicly accessible HTTPS website.

## Structure

```
demo-infra/
├── app/                    # Minimal Rails 7.2 application
├── config/                 # Server config files (systemd service, nginx)
├── scripts/
│   ├── lib/demo.sh         # Shared config (SERVER_IP, DOMAIN, APP_USER)
│   ├── 01_instance_creation.sh   ← runs locally
│   ├── 02_ssh_access.sh          ← runs locally, then SSHes into server
│   ├── 02_server_setup.sh        ← runs on server (uploaded via scp)
│   ├── 03_rails_install.sh       ← runs locally, then SSHes into server
│   ├── 03_server_rails.sh        ← runs on server
│   ├── 04_network.sh             ← runs locally, then SSHes into server
│   ├── 04_server_network.sh      ← runs on server
│   ├── 05_reverse_proxy.sh       ← runs locally, then SSHes into server
│   ├── 05_server_nginx.sh        ← runs on server
│   └── demo-magic/         # git submodule (paxtonhare/demo-magic)
├── terraform/              # IaC reference — Scaleway instance
└── ansible/                # IaC reference — service deployment
```

## How the scripts work

Each step is split into two files:

- **Local script** (`02_ssh_access.sh`, etc.) — runs on **your laptop**. It handles any local context, then uses `scp` to upload `demo-magic.sh` + the server-side companion script to the remote machine, and finally calls `ssh -t` to execute it.
- **Server script** (`02_server_setup.sh`, etc.) — runs **on the remote server** through that SSH connection. It sources `demo-magic.sh` from the server's home directory and replays the demo from there with the server's prompt.

```
Your laptop                          Remote server
─────────────────────────────────────────────────────
./02_ssh_access.sh
  │
  ├─ scp demo-magic.sh ──────────────→ ~/demo-magic.sh
  ├─ scp 02_server_setup.sh ─────────→ ~/02_server_setup.sh
  │
  ├─ p "ssh root@$SERVER_IP"         (typed on screen, not executed)
  └─ ssh -t root@$SERVER_IP ─────────→ bash ~/02_server_setup.sh
                                            │
                                            └─ demo runs here with
                                               server prompt & pe/p
```

The audience sees a **seamless transition**: the prompt changes from your local machine to the server's prompt mid-script.

## Before the demo

### 1. One-time setup

```bash
# Clone with submodules (includes demo-magic)
git clone --recurse-submodules https://github.com/agarov/demo-infra.git
chmod +x scripts/*.sh
```

If you already cloned without `--recurse-submodules`:

```bash
git submodule update --init
```

Install [`pv`](https://www.ivarch.com/programs/pv.shtml) for simulated typing effect (optional but recommended):

```bash
brew install pv          # macOS
apt install pv           # Ubuntu/Debian (on server too)
```

### 2. Configure your environment

Edit `scripts/lib/demo.sh` or export variables in your shell:

```bash
export SERVER_IP="51.158.x.x"       # public IP of your Scaleway instance
export DOMAIN="demo.yourcompany.com" # domain pointing to SERVER_IP
export APP_USER="demoapp"            # applicative user created during step 2
```

### 3. Provision the server (step 1)

Run `01_instance_creation.sh` **or** create the instance manually in the Scaleway console, then set `SERVER_IP`.  
Make sure your SSH public key is authorised on the server (`root` access required for steps 2 and 5).

## Running the demo

Each script is standalone. Run them in order, one per workshop step:

```bash
./scripts/01_instance_creation.sh   # local only — Terraform
./scripts/02_ssh_access.sh          # local intro → SSH into server
./scripts/03_rails_install.sh       # SSH into server as $APP_USER
./scripts/04_network.sh             # local intro → SSH into server
./scripts/05_reverse_proxy.sh       # SSH into server as root
```

Press **ENTER** to advance through each step.  
Use the `-n` flag to skip all waits (useful for dry runs):

```bash
./scripts/03_rails_install.sh -n
```

## Workshop steps

| Script | Where it runs | Topic |
|--------|--------------|-------|
| `01_instance_creation.sh` | local | Cloud provider, Terraform |
| `02_ssh_access.sh` + `02_server_setup.sh` | local → server (root) | SSH, keys, app user |
| `03_rails_install.sh` + `03_server_rails.sh` | local → server (demoapp) | Ruby, Rails, systemd |
| `04_network.sh` + `04_server_network.sh` | local → server (demoapp) | IP, ports, DNS, TLS |
| `05_reverse_proxy.sh` + `05_server_nginx.sh` | local → server (root) | NGINX, Let's Encrypt |

## The Rails app

The `app/` directory is a minimal Rails 7.2 app with a single welcome page.  
It is intentionally bare-bones — the app is not the focus of this workshop.

To run it locally:

```bash
cd app
bundle install
bin/rails db:create
bin/rails server
# → http://localhost:3000
```
