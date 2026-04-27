# =============================================================================
# PiSi Nostaljisi - ~/.bashrc için
# Açıklama: Pardus'un efsane paket yöneticisi PiSi'yi simüle eder
# Kullanım: Bu dosyanın içeriğini ~/.bashrc sonuna ekle
#           veya: echo "source ~/pisi_nostalji.sh" >> ~/.bashrc
# =============================================================================

# ─── Renk Tanımları ──────────────────────────────────────────────────────────
_PISI_RED='\033[0;31m'
_PISI_GREEN='\033[0;32m'
_PISI_YELLOW='\033[1;33m'
_PISI_BLUE='\033[0;34m'
_PISI_CYAN='\033[0;36m'
_PISI_MAGENTA='\033[0;35m'
_PISI_BOLD='\033[1m'
_PISI_NC='\033[0m'

# ─── PiSi Logo Fonksiyonu ────────────────────────────────────────────────────
_pisi_logo() {
    echo -e "${_PISI_GREEN}${_PISI_BOLD}"
    echo -e "  ██████╗ ██╗███████╗██╗"
    echo -e "  ██╔══██╗██║██╔════╝██║"
    echo -e "  ██████╔╝██║███████╗██║"
    echo -e "  ██╔═══╝ ██║╚════██║██║"
    echo -e "  ██║     ██║███████║██║"
    echo -e "  ╚═╝     ╚═╝╚══════╝╚═╝"
    echo -e "  Pardus PiSi - Nostalji Modu 🌙${_PISI_NC}"
    echo ""
}

# ─── Yardımcı Mesaj Fonksiyonları ────────────────────────────────────────────

# İşlem başlangıç mesajı
_pisi_info() {
    echo -e "${_PISI_CYAN}${_PISI_BOLD}[PiSi]${_PISI_NC} $1"
}

# Başarı mesajı
_pisi_ok() {
    echo -e "${_PISI_GREEN}${_PISI_BOLD}[✓]${_PISI_NC} $1"
}

# Hata mesajı
_pisi_err() {
    echo -e "${_PISI_RED}${_PISI_BOLD}[✗]${_PISI_NC} $1"
}

# Uyarı mesajı
_pisi_warn() {
    echo -e "${_PISI_YELLOW}${_PISI_BOLD}[!]${_PISI_NC} $1"
}

# ─── Ana PiSi Fonksiyonu ─────────────────────────────────────────────────────
pisi() {

    # Argüman verilmemişse yardım göster
    if [[ $# -eq 0 ]]; then
        _pisi_logo
        echo -e "${_PISI_BOLD}Kullanım:${_PISI_NC} pisi <komut> [paket adı]"
        echo ""
        echo -e "${_PISI_CYAN}Paket İşlemleri:${_PISI_NC}"
        echo -e "  ${_PISI_GREEN}install${_PISI_NC}          Paket kur"
        echo -e "  ${_PISI_GREEN}remove${_PISI_NC}           Paket kaldır"
        echo -e "  ${_PISI_GREEN}purge${_PISI_NC}            Paket ve ayarlarını sil"
        echo -e "  ${_PISI_GREEN}upgrade${_PISI_NC}          Sistemi güncelle"
        echo -e "  ${_PISI_GREEN}update${_PISI_NC}           Paket listesini yenile"
        echo ""
        echo -e "${_PISI_CYAN}Arama ve Bilgi:${_PISI_NC}"
        echo -e "  ${_PISI_GREEN}search${_PISI_NC}           Paket ara"
        echo -e "  ${_PISI_GREEN}info${_PISI_NC}             Paket bilgisi göster"
        echo -e "  ${_PISI_GREEN}list-installed${_PISI_NC}   Kurulu paketleri listele"
        echo -e "  ${_PISI_GREEN}list-available${_PISI_NC}   Mevcut paketleri listele"
        echo ""
        echo -e "${_PISI_CYAN}Sistem:${_PISI_NC}"
        echo -e "  ${_PISI_GREEN}clean${_PISI_NC}            Önbelleği temizle"
        echo -e "  ${_PISI_GREEN}check${_PISI_NC}            Bozuk paketleri onar"
        echo -e "  ${_PISI_GREEN}history${_PISI_NC}          Kurulum geçmişi"
        echo ""
        echo -e "${_PISI_MAGENTA}  Pardus'un efsane paket yöneticisi PiSi - Nostalji Modu 🌙${_PISI_NC}"
        return 0
    fi

    local komut="$1"
    shift  # İlk argümanı (komutu) at, geri kalanlar paket adları

    case "$komut" in

        # ── Paket Kurma ──────────────────────────────────────────────────────
        install|it)
            if [[ $# -eq 0 ]]; then
                _pisi_err "Paket adı belirtmelisin!"
                echo -e "  Kullanım: ${_PISI_BOLD}pisi install <paket>${_PISI_NC}"
                return 1
            fi
            _pisi_info "Kuruluyor: ${_PISI_BOLD}$*${_PISI_NC}"
            echo -e "${_PISI_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_PISI_NC}"
            if sudo apt install -y "$@"; then
                echo -e "${_PISI_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_PISI_NC}"
                _pisi_ok "${_PISI_BOLD}$*${_PISI_NC} başarıyla kuruldu!"
            else
                echo -e "${_PISI_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_PISI_NC}"
                _pisi_err "${_PISI_BOLD}$*${_PISI_NC} kurulamadı!"
                return 1
            fi
            ;;

        # ── Paket Kaldırma ───────────────────────────────────────────────────
        remove|rm)
            if [[ $# -eq 0 ]]; then
                _pisi_err "Paket adı belirtmelisin!"
                return 1
            fi
            _pisi_warn "Kaldırılıyor: ${_PISI_BOLD}$*${_PISI_NC}"
            echo -e "${_PISI_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_PISI_NC}"
            if sudo apt remove -y "$@"; then
                echo -e "${_PISI_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_PISI_NC}"
                _pisi_ok "${_PISI_BOLD}$*${_PISI_NC} kaldırıldı!"
            else
                _pisi_err "Kaldırma işlemi başarısız!"
                return 1
            fi
            ;;

        # ── Paket ve Ayarlarını Sil ──────────────────────────────────────────
        purge)
            if [[ $# -eq 0 ]]; then
                _pisi_err "Paket adı belirtmelisin!"
                return 1
            fi
            _pisi_warn "Tamamen siliniyor: ${_PISI_BOLD}$*${_PISI_NC} (ayarlar dahil)"
            read -p "$(echo -e ${_PISI_RED}Emin misin? [e/H]:${_PISI_NC} )" -n 1 -r
            echo ""
            if [[ $REPLY =~ ^[Ee]$ ]]; then
                sudo apt purge -y "$@"
                _pisi_ok "Silindi!"
            else
                _pisi_info "İptal edildi."
            fi
            ;;

        # ── Sistem Güncelleme ────────────────────────────────────────────────
        upgrade|up)
            _pisi_info "Paket listesi yenileniyor..."
            sudo apt update
            echo ""
            _pisi_info "Sistem güncelleniyor..."
            echo -e "${_PISI_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_PISI_NC}"
            if sudo apt upgrade -y; then
                echo -e "${_PISI_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_PISI_NC}"
                _pisi_ok "Sistem güncellendi!"
            else
                _pisi_err "Güncelleme başarısız!"
                return 1
            fi
            ;;

        # ── Paket Listesi Yenile ─────────────────────────────────────────────
        update|ud)
            _pisi_info "Paket listesi yenileniyor..."
            echo -e "${_PISI_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_PISI_NC}"
            if sudo apt update; then
                echo -e "${_PISI_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_PISI_NC}"
                _pisi_ok "Paket listesi güncellendi!"
            else
                _pisi_err "Güncelleme başarısız!"
                return 1
            fi
            ;;

        # ── Paket Ara ────────────────────────────────────────────────────────
        search|sr)
            if [[ $# -eq 0 ]]; then
                _pisi_err "Arama terimi belirtmelisin!"
                return 1
            fi
            _pisi_info "Aranıyor: ${_PISI_BOLD}$*${_PISI_NC}"
            echo -e "${_PISI_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_PISI_NC}"
            apt search "$@" 2>/dev/null
            ;;

        # ── Paket Bilgisi ────────────────────────────────────────────────────
        info|if)
            if [[ $# -eq 0 ]]; then
                _pisi_err "Paket adı belirtmelisin!"
                return 1
            fi
            _pisi_info "Paket bilgisi: ${_PISI_BOLD}$*${_PISI_NC}"
            echo -e "${_PISI_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_PISI_NC}"
            apt show "$@" 2>/dev/null
            ;;

        # ── Kurulu Paketler ──────────────────────────────────────────────────
        list-installed|li)
            _pisi_info "Kurulu paketler listeleniyor..."
            echo -e "${_PISI_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_PISI_NC}"
            if [[ $# -gt 0 ]]; then
                # Filtre varsa uygula
                apt list --installed 2>/dev/null | grep "$1"
            else
                apt list --installed 2>/dev/null
            fi
            ;;

        # ── Mevcut Paketler ──────────────────────────────────────────────────
        list-available|la)
            _pisi_info "Mevcut paketler listeleniyor..."
            apt list 2>/dev/null | grep -v "Listing" | head -50
            _pisi_warn "İlk 50 paket gösterildi. Filtrelemek için: pisi list-available <isim>"
            ;;

        # ── Önbellek Temizle ─────────────────────────────────────────────────
        clean|cl)
            _pisi_info "Önbellek temizleniyor..."
            sudo apt autoremove -y
            sudo apt autoclean
            sudo apt clean
            _pisi_ok "Temizlik tamamlandı!"
            ;;

        # ── Bozuk Paketleri Onar ─────────────────────────────────────────────
        check|ch)
            _pisi_info "Sistem kontrol ediliyor..."
            echo -e "${_PISI_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_PISI_NC}"
            sudo apt install -f
            sudo dpkg --configure -a
            _pisi_ok "Kontrol tamamlandı!"
            ;;

        # ── Kurulum Geçmişi ──────────────────────────────────────────────────
        history|hs)
            _pisi_info "Kurulum geçmişi:"
            echo -e "${_PISI_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${_PISI_NC}"
            grep " install " /var/log/dpkg.log 2>/dev/null | tail -30 | \
            awk '{print $1, $2, $4}' | \
            while read tarih saat paket; do
                echo -e "  ${_PISI_GREEN}✓${_PISI_NC} ${_PISI_BOLD}$paket${_PISI_NC} ${_PISI_CYAN}($tarih $saat)${_PISI_NC}"
            done
            ;;

        # ── Bilinmeyen Komut ─────────────────────────────────────────────────
        *)
            _pisi_err "Bilinmeyen komut: ${_PISI_BOLD}$komut${_PISI_NC}"
            echo -e "  Yardım için: ${_PISI_BOLD}pisi${_PISI_NC}"
            return 1
            ;;
    esac
}

# ─── Kısa Alias'lar (opsiyonel) ──────────────────────────────────────────────
# Bunları istersen aktif edebilirsin (#'ı kaldır)
# alias pi='pisi install'
# alias pr='pisi remove'
# alias pu='pisi upgrade'
# alias ps='pisi search'

# ─── Hoş Geldin Mesajı ───────────────────────────────────────────────────────
echo -e "${_PISI_GREEN}${_PISI_BOLD}[PiSi]${_PISI_NC} Nostalji modu aktif! 🌙 Kullanım: ${_PISI_BOLD}pisi${_PISI_NC}"
