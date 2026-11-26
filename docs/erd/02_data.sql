-- 02_data.sql - Data Contoh Proyek SendIn (Kelompok BizByte)
USE sendin_db;

INSERT INTO pengguna (id_pengguna, nama, email, kata_sandi_hash, peran) VALUES
(1, 'Budi UMKM', 'budi@umkm.id', 'hash_budi', 'umkm'),
(2, 'Siti Kuliner', 'siti@umkm.id', 'hash_siti', 'umkm'),
(3, 'Andi Fashion', 'andi@umkm.id', 'hash_andi', 'umkm'),
(4, 'Dewi Kerajinan', 'dewi@umkm.id', 'hash_dewi', 'umkm'),
(5, 'Raka Kopi', 'raka@umkm.id', 'hash_raka', 'umkm'),
(6, 'Joko Kurir', 'joko@kurir.id', 'hash_joko', 'kurir'),
(7, 'Bagas Kurir', 'bagas@kurir.id', 'hash_bagas', 'kurir'),
(8, 'Tono Kurir', 'tono@kurir.id', 'hash_tono', 'kurir'),
(9, 'Dian Kurir', 'dian@kurir.id', 'hash_dian', 'kurir'),
(10, 'Rizal Kurir', 'rizal@kurir.id', 'hash_rizal', 'kurir'),
(11, 'Admin SendIn', 'admin@sendin.id', 'hash_admin', 'admin');

INSERT INTO umkm (id_umkm, id_pengguna, nama_usaha, alamat_gerai, no_telepon) VALUES
(1, 1, 'Dapur Budi', 'Jl. Kaliurang Km 5', '081200010001'),
(2, 2, 'Kue Siti', 'Jl. Gejayan 12', '081200010002'),
(3, 3, 'Andi Batik', 'Jl. Malioboro 40', '081200010003'),
(4, 4, 'Dewi Craft', 'Jl. Parangtritis 8', '081200010004'),
(5, 5, 'Kopi Raka', 'Jl. Jakal Km 9', '081200010005');

INSERT INTO kurir (id_kurir, id_pengguna, wilayah, status_tersedia, no_telepon) VALUES
(1, 6, 'Sleman Utara', 1, '081300020001'),
(2, 7, 'Sleman Selatan', 1, '081300020002'),
(3, 8, 'Kota Yogyakarta', 1, '081300020003'),
(4, 9, 'Bantul', 0, '081300020004'),
(5, 10, 'Sleman Barat', 1, '081300020005');

INSERT INTO kendaraan (id_kendaraan, id_kurir, jenis, kapasitas_kg) VALUES
(1, 1, 'Motor Matic', 20.00),
(2, 2, 'Motor Bebek', 25.00),
(3, 3, 'Motor Box', 40.00),
(4, 4, 'Motor Matic', 20.00),
(5, 5, 'Mobil Pick Up', 300.00);

INSERT INTO tarif (id_tarif, jarak_min_km, jarak_max_km, tarif_per_km, tarif_per_kg) VALUES
(1, 0.00, 3.00, 2500.00, 1000.00),
(2, 3.01, 6.00, 2200.00, 1000.00),
(3, 6.01, 10.00, 2000.00, 1200.00),
(4, 10.01, 15.00, 1800.00, 1500.00),
(5, 15.01, 25.00, 1700.00, 1500.00);

INSERT INTO order_kirim (id_order, id_umkm, id_tarif, alamat_jemput, alamat_tujuan, berat_kg, jenis_barang, total_tarif, status_terkini) VALUES
(1, 1, 1, 'Jl. Kaliurang Km 5', 'Jl. Pogung Baru 10', 2.00, 'Makanan', 7000.00, 'diterima'),
(2, 1, 2, 'Jl. Kaliurang Km 5', 'Jl. Seturan 22', 1.50, 'Makanan', 11000.00, 'diterima'),
(3, 2, 1, 'Jl. Gejayan 12', 'Jl. Demangan 4', 3.00, 'Kue Basah', 9500.00, 'diterima'),
(4, 2, 3, 'Jl. Gejayan 12', 'Jl. Bantul Km 4', 2.50, 'Kue Kering', 18000.00, 'dalam_perjalanan'),
(5, 3, 2, 'Jl. Malioboro 40', 'Jl. Magelang Km 5', 1.00, 'Pakaian', 10000.00, 'diterima'),
(6, 3, 3, 'Jl. Malioboro 40', 'Jl. Solo Km 8', 4.00, 'Kain Batik', 21000.00, 'dijemput'),
(7, 4, 4, 'Jl. Parangtritis 8', 'Jl. Kaliurang Km 12', 5.00, 'Kerajinan', 28000.00, 'menunggu'),
(8, 1, 1, 'Jl. Kaliurang Km 5', 'Jl. Jakal Km 7', 1.00, 'Minuman', 6500.00, 'diterima');

-- Tabel jembatan penugasan (8 baris; kurir 5 sengaja belum dapat tugas)
INSERT INTO penugasan (id_penugasan, id_order, id_kurir, waktu_tugas, urutan_rute) VALUES
(1, 1, 1, '2026-11-20 08:10:00', 1),
(2, 2, 1, '2026-11-20 09:00:00', 2),
(3, 3, 2, '2026-11-20 10:15:00', 1),
(4, 4, 2, '2026-11-20 11:00:00', 2),
(5, 5, 3, '2026-11-21 08:30:00', 1),
(6, 6, 3, '2026-11-21 09:45:00', 2),
(7, 8, 1, '2026-11-22 10:00:00', 1),
(8, 4, 4, '2026-11-22 13:00:00', 1);

INSERT INTO riwayat_status (id_riwayat, id_order, status, waktu_ubah) VALUES
(1, 1, 'menunggu', '2026-11-20 08:00:00'),
(2, 1, 'dijemput', '2026-11-20 08:20:00'),
(3, 1, 'diterima', '2026-11-20 08:50:00'),
(4, 2, 'diterima', '2026-11-20 09:40:00'),
(5, 3, 'diterima', '2026-11-20 10:55:00'),
(6, 4, 'dalam_perjalanan', '2026-11-20 11:30:00'),
(7, 5, 'diterima', '2026-11-21 09:10:00'),
(8, 8, 'diterima', '2026-11-22 10:35:00');

-- Hanya order yang sudah diterima yang punya bukti terima (5 baris)
INSERT INTO bukti_terima (id_bukti, id_order, path_foto, path_ttd) VALUES
(1, 1, 'uploads/foto_1.jpg', 'uploads/ttd_1.png'),
(2, 2, 'uploads/foto_2.jpg', 'uploads/ttd_2.png'),
(3, 3, 'uploads/foto_3.jpg', 'uploads/ttd_3.png'),
(4, 5, 'uploads/foto_5.jpg', 'uploads/ttd_5.png'),
(5, 8, 'uploads/foto_8.jpg', 'uploads/ttd_8.png');
