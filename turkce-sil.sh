#!/bin/bash

echo "🧹 Türkçe komut sistemi kaldırılıyor..."

ALIAS_DOSYA="$HOME/turkce.sh"
KILAVUZ="$HOME/kılavuz.txt"
BASHRC="$HOME/.bashrc"
ZSHRC="$HOME/.zshrc"
FISHRC="$HOME/.config/fish/config.fish"

# alias dosyasını sil
if [ -f "$ALIAS_DOSYA" ]; then
  rm "$ALIAS_DOSYA"
  echo "🗑️ $ALIAS_DOSYA silindi."
fi

# kılavuz dosyasını sil
if [ -f "$KILAVUZ" ]; then
  rm "$KILAVUZ"
  echo "🗑️ $KILAVUZ silindi."
fi

# .bashrc ve .zshrc ve fish'ten source satırını kaldır
for shellrc in "$BASHRC" "$ZSHRC" "$FISHRC"; do
  if [ -f "$shellrc" ]; then
    if grep -q "source \$HOME/turkce.sh" "$shellrc"; then
      sed -i '/source \$HOME\/turkce.sh/d' "$shellrc"
      echo "✅ $shellrc içinden kaldırıldı."
    fi
  fi
done

echo "✅ Kaldırma işlemi tamamlandı. Terminali yeniden başlat ya da 'source ~/.bashrc' komutunu çalıştır."
