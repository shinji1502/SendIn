-- 03_query.sql - Query Bisnis Proyek SendIn (Kelompok BizByte)
USE sendin_db;

-- Query 1: Order apa saja yang sudah ditugaskan beserta nama UMKM dan kurirnya?
-- Halaman/Fitur: Dashboard Admin dan Pelacakan Order
-- Jumlah baris hasil: 8 baris
SELECT o.id_order, u.nama_usaha, p.nama AS nama_kurir, o.status_terkini
FROM order_kirim o
JOIN umkm u ON o.id_umkm = u.id_umkm
JOIN penugasan pn ON o.id_order = pn.id_order
JOIN kurir k ON pn.id_kurir = k.id_kurir
JOIN pengguna p ON k.id_pengguna = p.id_pengguna;

-- Query 2: Order mana saja yang belum memiliki bukti terima digital?
-- Halaman/Fitur: Audit Bukti Terima dan Sengketa
-- Jumlah baris hasil: 3 baris
SELECT o.id_order, u.nama_usaha, o.status_terkini
FROM order_kirim o
JOIN umkm u ON o.id_umkm = u.id_umkm
LEFT JOIN bukti_terima b ON o.id_order = b.id_order
WHERE b.id_bukti IS NULL;

-- Query 3: Kurir mana yang belum pernah mendapat penugasan kirim?
-- Halaman/Fitur: Manajemen Kurir dan Penugasan Otomatis
-- Jumlah baris hasil: 1 baris
SELECT p.nama AS nama_kurir, k.wilayah
FROM kurir k
JOIN pengguna p ON k.id_pengguna = p.id_pengguna
LEFT JOIN penugasan pn ON k.id_kurir = pn.id_kurir
WHERE pn.id_penugasan IS NULL;

-- Query 4: UMKM mana saja yang sudah mengirim minimal 2 order beserta total biayanya?
-- Halaman/Fitur: Dashboard SLA Manajer Operasional
-- Jumlah baris hasil: 3 baris
SELECT u.nama_usaha, COUNT(o.id_order) AS jumlah_order, SUM(o.total_tarif) AS total_biaya
FROM umkm u
JOIN order_kirim o ON u.id_umkm = o.id_umkm
GROUP BY u.id_umkm, u.nama_usaha
HAVING COUNT(o.id_order) >= 2
ORDER BY jumlah_order DESC;

-- Query 5: Order mana yang tarifnya di atas rata-rata tarif seluruh pengiriman?
-- Halaman/Fitur: Analisis Efisiensi Biaya Kirim
-- Jumlah baris hasil: 3 baris
SELECT id_order, jenis_barang, total_tarif
FROM order_kirim
WHERE total_tarif > (SELECT AVG(total_tarif) FROM order_kirim)
ORDER BY total_tarif DESC;

-- Query 6: Berapa jumlah penugasan masing-masing kurir termasuk yang belum dapat tugas?
-- Halaman/Fitur: Rekap Performa Kurir
-- Jumlah baris hasil: 5 baris
SELECT p.nama AS nama_kurir, COUNT(pn.id_penugasan) AS total_tugas
FROM kurir k
JOIN pengguna p ON k.id_pengguna = p.id_pengguna
LEFT JOIN penugasan pn ON k.id_kurir = pn.id_kurir
GROUP BY k.id_kurir, p.nama
ORDER BY total_tugas DESC;
