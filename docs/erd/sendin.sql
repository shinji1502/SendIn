--Basis Ddata proyek sendin
CREATE DATABASE IF NOT EXISTS sendin_db;
USE sendin_db;

CREATE TABLE pengguna (
  id_pengguna INT AUTO_INCREMENT PRIMARY KEY,
  nama VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  kata_sandi_hash VARCHAR(255) NOT NULL,
  peran ENUM('umkm', 'admin', 'kurir', 'pelanggan', 'manajer') NOT NULL
);

CREATE TABLE umkm (
  id_umkm INT AUTO_INCREMENT PRIMARY KEY,
  id_pengguna INT NOT NULL,
  nama_usaha VARCHAR(120) NOT NULL,
  alamat_gerai TEXT NOT NULL,
  no_telepon VARCHAR(20) NOT NULL,
  FOREIGN KEY (id_pengguna) REFERENCES pengguna(id_pengguna)
);

CREATE TABLE kurir (
  id_kurir INT AUTO_INCREMENT PRIMARY KEY,
  id_pengguna INT NOT NULL,
  wilayah VARCHAR(80) NOT NULL,
  status_tersedia TINYINT(1) DEFAULT 1,
  no_telepon VARCHAR(20) NOT NULL,
  FOREIGN KEY (id_pengguna) REFERENCES pengguna(id_pengguna)
);

CREATE TABLE kendaraan (
  id_kendaraan INT AUTO_INCREMENT PRIMARY KEY,
  id_kurir INT NOT NULL,
  jenis VARCHAR(50) NOT NULL,
  kapasitas_kg DECIMAL(6,2) NOT NULL,
  FOREIGN KEY (id_kurir) REFERENCES kurir(id_kurir)
);

CREATE TABLE tarif (
  id_tarif INT AUTO_INCREMENT PRIMARY KEY,
  jarak_min_km DECIMAL(6,2) NOT NULL,
  jarak_max_km DECIMAL(6,2) NOT NULL,
  tarif_per_km DECIMAL(10,2) NOT NULL,
  tarif_per_kg DECIMAL(10,2) NOT NULL
);

CREATE TABLE order_kirim (
  id_order INT AUTO_INCREMENT PRIMARY KEY,
  id_umkm INT NOT NULL,
  id_tarif INT NOT NULL,
  alamat_jemput TEXT NOT NULL,
  alamat_tujuan TEXT NOT NULL,
  berat_kg DECIMAL(6,2) NOT NULL,
  jenis_barang VARCHAR(80) NOT NULL,
  total_tarif DECIMAL(12,2) NOT NULL,
  status_terkini ENUM('menunggu', 'dijemput', 'dalam_perjalanan', 'diterima', 'gagal') DEFAULT 'menunggu',
  FOREIGN KEY (id_umkm) REFERENCES umkm(id_umkm),
  FOREIGN KEY (id_tarif) REFERENCES tarif(id_tarif)
);

CREATE TABLE penugasan (
  id_penugasan INT AUTO_INCREMENT PRIMARY KEY,
  id_order INT NOT NULL,
  id_kurir INT NOT NULL,
  waktu_tugas DATETIME NOT NULL,
  urutan_rute INT DEFAULT 1,
  FOREIGN KEY (id_order) REFERENCES order_kirim(id_order),
  FOREIGN KEY (id_kurir) REFERENCES kurir(id_kurir)
);

CREATE TABLE riwayat_status (
  id_riwayat INT AUTO_INCREMENT PRIMARY KEY,
  id_order INT NOT NULL,
  status ENUM('menunggu', 'dijemput', 'dalam_perjalanan', 'diterima', 'gagal') NOT NULL,
  waktu_ubah DATETIME NOT NULL,
  FOREIGN KEY (id_order) REFERENCES order_kirim(id_order)
);

CREATE TABLE bukti_terima (
  id_bukti INT AUTO_INCREMENT PRIMARY KEY,
  id_order INT NOT NULL UNIQUE,
  path_foto VARCHAR(255) NOT NULL,
  path_ttd VARCHAR(255) NOT NULL,
  FOREIGN KEY (id_order) REFERENCES order_kirim(id_order)
);
