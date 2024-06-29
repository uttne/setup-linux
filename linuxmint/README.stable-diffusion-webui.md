# Stable Diffusion WebUI

## 初期設定

```bash
cd ~
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
cd stable-diffusion-webui/

# poetry の設定を pyproject.toml に書き込む
poetry init

# shell を起動する
poetry shell

# PyTorch をインストール
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121


# TCMalloc のインストール
sudo apt update
sudo apt -y install google-perftools libgoogle-perftools-dev

echo 'export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libtcmalloc.so' >> ~/.bashrc
source ~/.bashrc

# 実行
./webui.sh --listen
```

## 起動する

```bash
poetry shell
./webui.sh --listen

```