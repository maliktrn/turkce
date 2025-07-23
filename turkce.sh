#!/bin/bash
ALIAS_DOSYASI="$HOME/.turkce.sh"
BASHRC="$HOME/.bashrc"
ZSHRC="$HOME/.zshrc"

echo "🔧 Türkçe terminal komutları kuruluyor... Lütfen bekleyiniz..."

cat <<'EOL' > "$ALIAS_DOSYASI"
# Türkçe terminal komutları ve fonksiyonları

# ---- Fonksiyonlar ----
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

# ---- Alias’lar ----
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

# dikkat! kodun burdan sonrası kalıcı yapar eğer kalıcı olmasını istemiyorsanız kodun burdan sonrasını silerek tek seferlik deneyebilirsiniz 
# ama terminal açılıp kapandığında komut çalışmaz tekrar çalıştırmak için tekrar kurulum yapmanız gerekiyor
for shellrc in "$BASHRC" "$ZSHRC"; do
  if [ -f "$shellrc" ] && ! grep -Fxq "source \$HOME/.turkce-terminal.sh" "$shellrc"; then
    echo "source \$HOME/.turkce.sh" >> "$shellrc"
    echo "✅ $shellrc dosyasına eklendi"
  fi
done

echo "✅ Kurulum tamamlandı!"
echo "ℹ️  Artık tüm komutlar Türkçeleştirildi isterseniz oku kılavuz.txt komutu ile kılavuzda yazan komutları kullanmaya başlayabilirsiniz."
