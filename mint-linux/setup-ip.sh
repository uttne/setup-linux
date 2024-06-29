#!/bin/bash

DEVICE_NAME=$1
IP_ADDRESS=$2
DEFAULT_GATEWAY=$3

# デバイス名が指定されていない場合、ユーザーに入力を促す
if [ -z "$DEVICE_NAME" ]; then
    read -p "Please enter the device name: " DEVICE_NAME
fi

# IPアドレスが指定されていない場合、ユーザーに入力を促す
if [ -z "$IP_ADDRESS" ]; then
    read -p "Please enter the IP address: " IP_ADDRESS
fi

# Default Gatewayが指定されていない場合、ユーザーに入力を促す
if [ -z "$DEFAULT_GATEWAY" ]; then
    read -p "Please enter the default gateway address: " DEFAULT_GATEWAY
fi

# 入力結果を表示
echo "Device name: $DEVICE_NAME"
echo "IP address: $IP_ADDRESS"
echo "Default gateway address: $DEFAULT_GATEWAY"

# どれかが空であればエラーで終了
if [ -z "$DEVICE_NAME" ] || [ -z "$IP_ADDRESS" ] || [ -z "$DEFAULT_GATEWAY" ]; then
    echo "Error: All values must be provided."
    exit 1
fi


# デバイスが存在するか確認
if ! nmcli device | grep -q "^$DEVICE_NAME"; then
    echo "Error: Device '$DEVICE_NAME' does not exist."
    exit 1
fi

# コネクション名を取得
CONNECTION_NAME=$(nmcli -g NAME,DEVICE connection show --active | grep "$DEVICE_NAME" | awk -F: '{print $1}')

# コネクション名が取得できたか確認
if [ -z "$CONNECTION_NAME" ]; then
    echo "Error: No active connection found for device '$DEVICE_NAME'."
    exit 1
fi

# 変数に格納して表示
echo "Connection name for device '$DEVICE_NAME' is '$CONNECTION_NAME'."

# ip の設定
nmcli connection modify "$CONNECTION_NAME" ipv4.addresses $IP_ADDRESS/24
nmcli connection modify "$CONNECTION_NAME" ipv4.gateway $DEFAULT_GATEWAY
nmcli connection modify "$CONNECTION_NAME" ipv4.method mamual

# DNS の設定
nmcli connection modify "$CONNECTION_NAME" ipv4.dns "8.8.8.8 8.8.4.4"
nmcli connection modify "$CONNECTION_NAME" ipv4.ignore-auto-dns yes

# 接続を再起動
nmcli connection down "$CONNECTION_NAME" && nmcli connection up "$CONNECTION_NAME"

# 変更結果を表示
nmcli connection show "$CONNECTION_NAME" | grep ipv4
