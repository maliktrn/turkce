#!/bin/bash

ALIAS_DOSYASI="$HOME/turkce.sh"
BASHRC="$HOME/.bashrc"
ZSHRC="$HOME/.zshrc"
FISHRC="$HOME/.config/fish/config.fish"

echo "🔧 Türkçe terminal komutları kuruluyor..."

#hangi dağıtımı kullandığına bakıyor bu kısım
if command -v pacman &> /dev/null; then
  YUKLE="yönetici pacman -S"
  KALDIR="yönetici pacman -R"
  GUNCELLE="yönetici pacman -Syu"
elif command -v dnf &> /dev/null; then
  YUKLE="yönetici dnf install"
  KALDIR="yönetici dnf remove"
  GUNCELLE="yönetici dnf upgrade"
elif command -v zypper &> /dev/null; then
  YUKLE="yönetici zypper install"
  KALDIR="yönetici zypper remove"
  GUNCELLE="yönetici zypper update"
elif command -v apt &> /dev/null; then
  YUKLE="yönetici apt install"
  KALDIR="yönetici apt remove"
  GUNCELLE="yönetici apt update && yönetici apt upgrade -y"
else
  YUKLE="echo '❌ Paket yöneticisi bulunamadı'"
  KALDIR="$YUKLE"
  GUNCELLE="$YUKLE"
fi

cat <<EOL > "$ALIAS_DOSYASI"
# Türkçe terminal alias ve fonksiyonları

yardım() {
  cat "\$HOME/turkce/kılavuz.txt"
}

göster() {
  local args=()
  for arg in "\$@"; do
    case "\$arg" in
      -tümü) args+=("-a") ;;
      -uzun) args+=("-l") ;;
      -renkli) args+=("--color=auto") ;;
      -tarihegöre) args+=("-lt") ;;
      -ters) args+=("-r") ;;
      -boyut) args+=("-S") ;;
      *) args+=("\$arg") ;;
    esac
  done
  command ls "\${args[@]}"
}

alias gir='cd'
alias neredeyim='pwd'
alias kimimben='whoami'
alias kiminle='groups'
alias klasöroluştur='mkdir'
alias klasörsil='rmdir'
alias sil='rm -i'
alias silr='rm -r'
alias kopyala='cp'
alias taşı='mv'
alias dosyayaz='touch'
alias düzenle='nano'
alias temizle='clear'
alias çık='exit'
alias ağaç='tree'
alias durum='top'
alias yükle='$YUKLE'
alias kaldır='$KALDIR'
alias güncelle='$GUNCELLE'
alias paketkontrol='dpkg -l'
alias diskkullanımı='df -h'
alias klasörkullanımı='du -sh *'
alias değiştirizin='chmod'
alias sahipol='chown'
alias linkyap='ln -s'
alias md5='md5sum'
alias sha1='sha1sum'
alias sha256='sha256sum'
alias parçala='split'
alias oku='cat'
alias ilk='head'
alias son='tail'
alias satırsay='wc -l'
alias kelimesay='wc -w'
alias baytsay='wc -c'
alias sırala='sort'
alias eşsiz='uniq'
alias ara='grep'
alias değiştir='sed'
alias dönüştür='tr'
alias bekle='sleep'
alias zaman='date'
alias arkaplan='nohup'
alias çalıştır= 'bash'
alias çevre='env'
alias sistembilgi='uname -a'
EOL

# zsh varmı varsa ekle
if command -v zsh &> /dev/null && [ -f "$ZSHRC" ]; then
  if ! grep -Fxq "source \$HOME/turkce.sh" "$ZSHRC"; then
    echo 'source $HOME/turkce.sh' >> "$ZSHRC"
    echo "✅ ZSH için eklendi → $ZSHRC"
  fi
# yoksa bashe ekledim
elif [ -f "$BASHRC" ]; then
  if ! grep -Fxq "source \$HOME/turkce.sh" "$BASHRC"; then
    echo 'source $HOME/turkce.sh' >> "$BASHRC"
    echo "✅ Bash için eklendi → $BASHRC"
  fi
fi

# fish
if [ -f "$FISHRC" ]; then
  if ! grep -Fxq "source \$HOME/turkce.sh" "$FISHRC"; then
    echo 'source $HOME/turkce.sh' >> "$FISHRC"
    echo "✅ Fish için eklendi → $FISHRC"
  fi
fi

echo "✅ Kurulum tamamlandı!"
echo "ℹ️ Terminali kapatıp açman yeterli. Veya şu komutu çalıştır: source \$HOME/turkce.sh"
