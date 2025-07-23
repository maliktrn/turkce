#!/bin/bash

# ⚠️ Satır sonu kontrolü: Windows (CRLF) satır sonları varsa temizle
if grep -q $'\r' "$0"; then
  echo "⚠️ CRLF (Windows) satır sonları tespit edildi. Temizleniyor..."
  tr -d '\r' < "$0" > /tmp/turkce_temp.sh
  chmod +x /tmp/turkce_temp.sh
  exec /tmp/turkce_temp.sh
  exit 0
fi

# Alias/fonksiyonlar kaydedileceği yer
ALIAS_DOSYASI="$HOME/.turkce.sh"
BASHRC="$HOME/.bashrc"
ZSHRC="$HOME/.zshrc"

echo "🔧 Türkçe terminal komutları kuruluyor..."

# Türkçe terminal komutlarını alias ve fonksiyon olarak yaz
cat <<'EOL' > "$ALIAS_DOSYASI"
# Türkçe terminal komutları ve fonksiyonları

göster() {
  local args=()
  for arg in "$@"; do
    case "$arg" in
      -tümü) args+=("-a") ;;
      -uzun) args+=("-l") ;;
      -renkli) args+=("--color=auto") ;;
      -tarihe-göre) args+=("-lt") ;;
      -ters) args+=("-r") ;;
      -boyut) args+=("-S") ;;
      *) args+=("$arg") ;;
    esac
  done
  command ls "${args[@]}"
}

alias gir='cd'
alias nerdeyim='pwd'
alias kimimben='whoami'
alias kiminle='groups'
alias klasöroluştur='mkdir'
alias klasörsil='rmdir'
alias sil='rm -i'
alias sil_r='rm -r'
alias kopyala='cp'
alias taşı='mv'
alias dosyayaz='touch'
alias düzenle='nano'
alias temizle='clear'
alias çık='exit'
alias ağaç='tree'
alias durum='top'
alias yükle='sudo apt install'
alias kaldır='sudo apt remove'
alias güncelle='sudo apt update && sudo apt upgrade -y'
alias paketkontrol='dpkg -l'
alias disk_kullanımı='df -h'
alias klasör_kullanımı='du -sh *'
alias değiştir_mod='chmod'
alias sahip_ol='chown'
alias link_yap='ln -s'
alias checksum_md5='md5sum'
alias checksum_sha1='sha1sum'
alias checksum_sha256='sha256sum'
alias parçala='split'
alias oku='cat'
alias ilk='head'
alias son='tail'
alias satırsayı='wc -l'
alias kelimesayı='wc -w'
alias baytsayı='wc -c'
alias sırala='sort'
alias eşsiz='uniq'
alias arama='grep'
alias değiştir_sorgu='sed'
alias karakter_dönüştür='tr'
alias bekle='sleep'
alias zaman='date'
alias arkaplanda='nohup'
alias çevre='env'
alias sistem_bilgi='uname -a'
EOL

# ~/.bashrc ve ~/.zshrc içine otomatik kaynak satırı ekle
for shellrc in "$BASHRC" "$ZSHRC"; do
  if [ -f "$shellrc" ] && ! grep -Fxq "source \$HOME/.turkce.sh" "$shellrc"; then
    echo "source \$HOME/.turkce.sh" >> "$shellrc"
    echo "✅ $shellrc dosyasına 'source' satırı eklendi."
  fi
done

echo -e "\n✅ Kurulum tamamlandı!"
echo "💡 Terminali kapatıp aç veya şunu yaz: source ~/.bashrc"
echo "🧪 Örnek: 'göster -uzun', 'nerdeyim', 'oku dosya.txt'"
