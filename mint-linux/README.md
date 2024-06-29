# Mint Linux

## 1. フォルダ名を英語に変換

これは GUI の操作が入る

```bash
LANG=C xdg-user-dirs-update --force
```

## 2. ソフトウェアソースの変更

メインを変更する

[]()

## 3. apt update 6 upgrade

```bash
sudo apt update
sudo apt upgrade -y
```

## 4. git をインストール

```bash
sudo apt install git -y
git config --global user.name "$USERNAME"
git config --global user.email "$EMAIL"

```


## 5. ip を固定

connection で指定すると永続化する。device で指定すると一時的になる。

```bash
# ネットワークインターフェースの確認
nmcli device
# 現在の接続名の確認
nmcli connection show

# ip の設定
nmcli connection modify "$CONNECTION_NAME" ipv4.addresses 192.168.1.100/24
nmcli connection modify "$CONNECTION_NAME" ipv4.gateway 192.168.1.1
nmcli connection modify "$CONNECTION_NAME" ipv4.method mamual

# DNS の設定
nmcli connection modify "$CONNECTION_NAME" ipv4.dns "8.8.8.8 8.8.4.4"
nmcli connection modify "$CONNECTION_NAME" ipv4.ignore-auto-dns yes

# 接続を再起動
nmcli connection down "$CONNECTION_NAME" && nmcli connection up "$CONNECTION_NAME"
```



## 2. SSH の設定

```bash
sudo apt -y install openssh-server
