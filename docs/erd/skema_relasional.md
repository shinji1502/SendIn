# Pemetaan ERD ke Skema Relasional — Proyek SendIn

## 1. Aturan Pemetaan Relasi ERD (Aturan 1–7)

| Bagian / Relasi ERD | Kardinalitas / Jenis | Aturan | Hasil Pemetaan pada Skema |
| :--- | :---: | :---: | :--- |
| `PENGGUNA` memiliki profil `UMKM` | 1:1 (Spesialisasi) | **Aturan 2** | FK `id_pengguna` diletakkan pada tabel `umkm`. |
| `PENGGUNA` memiliki profil `KURIR` | 1:1 (Spesialisasi) | **Aturan 2** | FK `id_pengguna` diletakkan pada tabel `kurir`. |
| `KURIR` mengoperasikan `KENDARAAN` | 1:N | **Aturan 3** | FK `id_kurir` diletakkan pada tabel `kendaraan` (sisi banyak). |
| `UMKM` membuat `ORDER_KIRIM` | 1:N | **Aturan 3** | FK `id_umkm` diletakkan pada tabel `order_kirim` (sisi banyak). |
| `TARIF` menentukan biaya `ORDER_KIRIM` | 1:N | **Aturan 3** | FK `id_tarif` diletakkan pada tabel `order_kirim` (sisi banyak). |
| `ORDER_KIRIM` dijadwalkan dalam `PENUGASAN` | 1:N | **Aturan 3** | FK `id_order` diletakkan pada tabel `penugasan` (sisi banyak). |
| `KURIR` menerima `PENUGASAN` | 1:N | **Aturan 3** | FK `id_kurir` diletakkan pada tabel `penugasan` (sisi banyak). |
| `ORDER_KIRIM` mencatat `RIWAYAT_STATUS` | 1:N | **Aturan 3** | FK `id_order` diletakkan pada tabel `riwayat_status` (sisi banyak). |
| `ORDER_KIRIM` memiliki `BUKTI_TERIMA` | 1:1 | **Aturan 2** | FK `id_order` (`NOT NULL UNIQUE`) diletakkan pada tabel `bukti_terima`. |

---

## 2. Skema Relasional (`nama_tabel(PK, kolom, FK)`)

* **pengguna**(`id_pengguna`, nama, email, kata_sandi_hash, peran)  
  FK: tidak ada

* **umkm**(`id_umkm`, *id_pengguna*, nama_usaha, alamat_gerai, no_telepon)  
  FK: `id_pengguna` → `pengguna`

* **kurir**(`id_kurir`, *id_pengguna*, wilayah, status_tersedia, no_telepon)  
  FK: `id_pengguna` → `pengguna`

* **kendaraan**(`id_kendaraan`, *id_kurir*, jenis, kapasitas_kg)  
  FK: `id_kurir` → `kurir`

* **tarif**(`id_tarif`, jarak_min_km, jarak_max_km, tarif_per_km, tarif_per_kg)  
  FK: tidak ada

* **order_kirim**(`id_order`, *id_umkm*, *id_tarif*, alamat_jemput, alamat_tujuan, berat_kg, jenis_barang, total_tarif, status_terkini)  
  FK: `id_umkm` → `umkm`, `id_tarif` → `tarif`

* **penugasan**(`id_penugasan`, *id_order*, *id_kurir*, waktu_tugas, urutan_rute)  
  FK: `id_order` → `order_kirim`, `id_kurir` → `kurir`

* **riwayat_status**(`id_riwayat`, *id_order*, status, waktu_ubah)  
  FK: `id_order` → `order_kirim`

* **bukti_terima**(`id_bukti`, *id_order*, path_foto, path_ttd)  
  FK: `id_order` → `order_kirim`
