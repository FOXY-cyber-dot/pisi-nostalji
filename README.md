# 🌙 PiSi Nostalji Modu

Pardus'un efsane paket yöneticisi **PiSi**'yi `apt` üzerine simüle eden Bash wrapper'ı.

## Kurulum

```bash
cp pisi_nostalji.sh ~/.pisi_nostalji.sh
echo "source ~/.pisi_nostalji.sh" >> ~/.bashrc
source ~/.bashrc
```

## Kullanım

| Komut | Açıklama |
|-------|----------|
| `pisi install <paket>` | Paket kur |
| `pisi remove <paket>` | Paket kaldır |
| `pisi upgrade` | Sistemi güncelle |
| `pisi search <paket>` | Paket ara |
| `pisi info <paket>` | Paket bilgisi |
| `pisi clean` | Önbellek temizle |
| `pisi history` | Kurulum geçmişi |

## Neden?

Pardus 2013'te Debian'a geçince PiSi hayatını kaybetti.
Bu proje o nostaljiyi yaşatmak için yazıldı. 🌙

## Lisans
GPL-2.0
