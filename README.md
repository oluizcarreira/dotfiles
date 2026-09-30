# 🛠️ My Dotfiles & System Setup

Configurações pessoais, automação de pós-instalação e ambientes isolados para distribuições Linux imutáveis, com foco em **Aurora Linux** e **Bluefin**.

Embora o projeto tenha sido desenvolvido pensando nessas distribuições, os scripts e configurações podem ser adaptados e utilizados em outros sistemas Linux.

---

## 📋 Pré-requisitos

Antes de iniciar, certifique-se de que você possui:

- Uma instalação funcional do Linux;
- `git` instalado;
- Acesso ao GitHub;
- Uma chave SSH configurada para acessar este repositório privado;
- Conexão com a internet.

---

## 🔐 Configuração do SSH

Como este repositório é privado, configure sua chave SSH antes de tentar cloná-lo.

### 1. Gerar uma nova chave SSH

Execute no terminal:

```bash
ssh-keygen -t ed25519 -C "seu-email@exemplo.com"
```

Pressione `Enter` para aceitar o caminho padrão:

```text
~/.ssh/id_ed25519
```

Caso seja solicitado, você também poderá definir uma senha para proteger sua chave privada.

### 2. Copiar a chave pública

Exiba o conteúdo da chave pública:

```bash
cat ~/.ssh/id_ed25519.pub
```

Copie todo o conteúdo exibido no terminal.

### 3. Adicionar a chave ao GitHub

No GitHub:

1. Acesse **Settings**;
2. Vá até **SSH and GPG keys**;
3. Clique em **New SSH key**;
4. Defina um nome para identificar o computador;
5. Cole o conteúdo da chave pública;
6. Salve a chave.

---

## 🚀 Instalação

Depois de configurar o SSH, clone o repositório e execute o script de inicialização.

### 1. Clonar o repositório

```bash
mkdir -p ~/Documents/projetos

git clone git@github.com:oluizcarreira/dotfiles.git \
    ~/Documents/projetos/dotfiles
```

### 2. Executar o bootstrap

```bash
cd ~/Documents/projetos/dotfiles

chmod +x bootstrap.sh
./bootstrap.sh
```

O `bootstrap.sh` funciona como o orquestrador principal e executa os scripts responsáveis pela configuração do ambiente.

---

## 📂 Estrutura do Repositório

```text
dotfiles/
├── bootstrap.sh             # Script principal de configuração
├── .gitignore               # Arquivos que não devem ser versionados
├── README.md                # Documentação do projeto
│
├── home/                    # Arquivos de configuração do usuário
│   ├── .gitconfig
│   ├── .p10k.zsh
│   ├── .tool-versions
│   └── .zshrc
│
└── scripts/
    ├── install-apps.sh      # Instalação de aplicativos e permissões
    ├── install-cli.sh       # Ferramentas CLI, Zsh, plugins, fontes e mise
    └── setup-distrobox.sh   # Criação dos ambientes Distrobox
```

---

## ⚙️ O que o Bootstrap Configura?

O processo de instalação é dividido em diferentes etapas para facilitar a manutenção e permitir que cada parte do ambiente seja configurada separadamente.

### 📦 Aplicações

O script `install-apps.sh` é responsável por configurar os aplicativos utilizados no sistema, incluindo aplicações distribuídas através do **Flatpak** e suas respectivas permissões.

### 🖥️ Ferramentas de Terminal

O script `install-cli.sh` configura ferramentas utilizadas no ambiente de desenvolvimento e no terminal, incluindo:

- Homebrew;
- Zsh;
- Oh My Zsh;
- Plugins do Zsh;
- Powerlevel10k;
- Fontes;
- `mise`;
- Outras ferramentas de linha de comando.

### 📦 Distrobox

O script `setup-distrobox.sh` cria os ambientes isolados utilizados para desenvolvimento e softwares específicos.

---

# 📦 Ambientes Isolados — Distrobox

O projeto utiliza **Distrobox** para manter o sistema base o mais limpo possível.

A ideia é utilizar o sistema operacional imutável como base e executar ferramentas de desenvolvimento e softwares específicos dentro de containers.

Os containers compartilham o diretório `$HOME`, permitindo trabalhar com os mesmos arquivos pessoais e projetos do sistema principal.

---

## 💻 Desenvolvimento — `dev-box`

O ambiente `dev-box` é baseado no **Ubuntu LTS** e concentra as principais ferramentas necessárias para desenvolvimento.

Entre os componentes instalados estão:

- `build-essential`;
- `git`;
- `curl`;
- `libssl-dev`;
- `libpq-dev`;
- `python3-dev`;
- Outras ferramentas necessárias para desenvolvimento.

### Entrar no ambiente

```bash
distrobox enter dev-box
```

---

## 🎬 DaVinci Resolve — `davinci-box`

O ambiente `davinci-box` é baseado no **Rocky Linux 9** e é destinado à execução do **DaVinci Resolve**, utilizando aceleração de GPU NVIDIA.

### Entrar no ambiente

```bash
distrobox enter davinci-box
```

### Instalar o DaVinci Resolve

O instalador oficial `.run` da Blackmagic Design deve ser executado dentro do container.

Após a instalação, o aplicativo pode ser exportado para o menu do sistema:

```bash
distrobox-export --app /opt/resolve/bin/resolve
```

Depois da exportação, o DaVinci Resolve poderá aparecer junto aos demais aplicativos do sistema.

---

# 🌐 Aplicações Web — PWA

Algumas aplicações web são utilizadas como aplicativos independentes através do navegador.

## Microsoft Teams

O Microsoft Teams não é instalado via Flatpak neste setup, principalmente para evitar possíveis problemas relacionados à autenticação empresarial e SSO.

Recomenda-se utilizar o **Google Chrome** ou **Brave** para criar uma aplicação web dedicada.

Acesse:

```text
https://teams.microsoft.com
```

Depois, no navegador, utilize a opção **Instalar Microsoft Teams** ou **Instalar aplicativo**, dependendo do navegador utilizado.

---

# 🧩 Filosofia do Projeto

Este projeto segue alguns princípios:

- 🧹 Manter o sistema base o mais limpo possível;
- 📦 Utilizar containers para ferramentas e ambientes específicos;
- 🔄 Facilitar a reprodução do ambiente em uma nova instalação;
- 🛠️ Automatizar tarefas repetitivas de configuração;
- 🔐 Evitar versionar informações sensíveis;
- 📝 Manter as configurações pessoais versionadas e organizadas.

A ideia é que uma nova instalação do sistema possa ser configurada com o mínimo possível de intervenção manual.

---

## ⚠️ Observações

Este repositório contém configurações pessoais e foi desenvolvido para atender às necessidades específicas do meu ambiente.

Antes de executar os scripts em outra máquina, revise principalmente:

- Aplicativos instalados;
- Caminhos de diretórios;
- Permissões;
- Configurações específicas de hardware;
- Drivers de GPU;
- Configurações do Distrobox;
- Variáveis de ambiente;
- Credenciais e tokens.

**Nunca adicione chaves privadas, senhas, tokens ou outras credenciais ao repositório.**

---

## 📄 Licença

Este projeto está sob a licença [MIT](LICENSE). Consulte o ficheiro `LICENSE` para obter mais detalhes.

As configurações e scripts destinam-se a uso pessoal, mas podem ser livremente utilizados, modificados e distribuídos como referência para o provisionamento e manutenção de ambientes Linux.
