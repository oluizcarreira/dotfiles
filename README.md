# 🛠️ My Dotfiles & System Setup

Personal configurations, post-installation automation, and isolated environments for immutable Linux distributions, with a focus on **Aurora Linux** and **Bluefin**.

Although this project was designed with these distributions in mind, the scripts and configurations can be adapted and used on other Linux systems.

---

## 📋 Prerequisites

Before getting started, make sure you have:

- A working Linux installation;
- `git` installed;
- Access to GitHub;
- An SSH key configured to access this private repository;
- An active internet connection.

---

## 🔐 SSH Configuration

Since this is a private repository, configure your SSH key before attempting to clone it.

### 1. Generate a New SSH Key

Run the following command in your terminal:

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
```

Press `Enter` to accept the default path:

```text
~/.ssh/id_ed25519
```

If prompted, you can also set a passphrase to protect your private key.

### 2. Copy the Public Key

Display your public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Copy the entire output displayed in the terminal.

### 3. Add the Key to GitHub

On GitHub:

1. Go to **Settings**;
2. Navigate to **SSH and GPG keys**;
3. Click **New SSH key**;
4. Give the key a name to identify the computer;
5. Paste the public key;
6. Save the key.

---

## 🚀 Installation

After configuring SSH, clone the repository and run the bootstrap script.

### 1. Clone the Repository

```bash
mkdir -p ~/Documents/projects

git clone git@github.com:oluizcarreira/dotfiles.git \
    ~/Documents/projects/dotfiles
```

### 2. Run the Bootstrap Script

```bash
cd ~/Documents/projects/dotfiles

chmod +x bootstrap.sh
./bootstrap.sh
```

The `bootstrap.sh` script acts as the main orchestrator and executes the scripts responsible for configuring the environment.

---

## 📂 Repository Structure

```text
dotfiles/
├── bootstrap.sh             # Main configuration script
├── .gitignore               # Files that should not be versioned
├── README.md                # Project documentation
│
├── home/                    # User configuration files
│   ├── .gitconfig
│   ├── .p10k.zsh
│   ├── .tool-versions
│   └── .zshrc
│
└── scripts/
    ├── install-apps.sh      # Application installation and permissions
    ├── install-cli.sh       # CLI tools, Zsh, plugins, fonts, and mise
    └── setup-distrobox.sh   # Distrobox environment setup
```

---

## ⚙️ What Does the Bootstrap Configure?

The installation process is divided into different stages to simplify maintenance and allow each part of the environment to be configured independently.

### 📦 Applications

The `install-apps.sh` script is responsible for configuring the applications used on the system, including applications distributed through **Flatpak** and their respective permissions.

### 🖥️ Terminal Tools

The `install-cli.sh` script configures tools used in the development environment and terminal, including:

- Homebrew;
- Zsh;
- Oh My Zsh;
- Zsh plugins;
- Powerlevel10k;
- Fonts;
- `mise`;
- Other command-line tools.

### 📦 Distrobox

The `setup-distrobox.sh` script creates the isolated environments used for development and specific software.

---

# 📦 Isolated Environments — Distrobox

This project uses **Distrobox** to keep the base operating system as clean as possible.

The idea is to use the immutable operating system as the foundation while running development tools and specific software inside containers.

The containers share the `$HOME` directory, allowing the same personal files and projects to be accessed from both the containers and the main system.

---

## 💻 Development — `dev-box`

The `dev-box` environment is based on **Ubuntu LTS** and contains the main tools required for development.

The installed components include:

- `build-essential`;
- `git`;
- `curl`;
- `libssl-dev`;
- `libpq-dev`;
- `python3-dev`;
- Other development tools and dependencies.

### Enter the Environment

```bash
distrobox enter dev-box
```

---

## 🎬 DaVinci Resolve — `davinci-box`

The `davinci-box` environment is based on **Rocky Linux 9** and is intended to run **DaVinci Resolve** using NVIDIA GPU acceleration.

### Enter the Environment

```bash
distrobox enter davinci-box
```

### Install DaVinci Resolve

The official `.run` installer provided by Blackmagic Design should be executed inside the container.

After installation, the application can be exported to the system application menu:

```bash
distrobox-export --app /opt/resolve/bin/resolve
```

After exporting it, DaVinci Resolve should appear alongside the other applications installed on the system.

---

# 🌐 Web Applications — PWA

Some web applications are used as standalone applications through the browser.

## Microsoft Teams

Microsoft Teams is not installed through Flatpak in this setup, mainly to avoid potential issues related to enterprise authentication and SSO.

It is recommended to use **Google Chrome** or **Brave** to create a dedicated web application.

Access:

```text
https://teams.microsoft.com
```

Then, in the browser, use the **Install Microsoft Teams** or **Install app** option, depending on the browser being used.

---

# 🧩 Project Philosophy

This project follows a few principles:

- 🧹 Keep the base operating system as clean as possible;
- 📦 Use containers for specific tools and environments;
- 🔄 Make the environment easy to reproduce on a fresh installation;
- 🛠️ Automate repetitive configuration tasks;
- 🔐 Avoid versioning sensitive information;
- 📝 Keep personal configurations versioned and organized.

The goal is to configure a fresh system with as little manual intervention as possible.

---

## ⚠️ Notes

This repository contains personal configurations and was developed to meet the specific requirements of my environment.

Before running the scripts on another machine, review the following:

- Installed applications;
- Directory paths;
- Permissions;
- Hardware-specific configurations;
- GPU drivers;
- Distrobox configurations;
- Environment variables;
- Credentials and tokens.

> **Never add private keys, passwords, tokens, or other credentials to this repository.**

---

## 📄 License

This project is licensed under the **MIT License**.

See the [`LICENSE`](LICENSE) file for the complete license text.

The configurations and scripts are intended for personal use, but may be freely used, modified, and distributed as a reference for provisioning and maintaining Linux environments.
