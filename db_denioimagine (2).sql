-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 06 Jun 2026 pada 12.37
-- Versi server: 8.4.3
-- Versi PHP: 8.3.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_denioimagine`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `carts`
--

CREATE TABLE `carts` (
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `durasi` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kategori` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stok` int NOT NULL,
  `gambar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `quantity` int NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `id` bigint NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '0001_01_01_000002_create_jobs_table', 1),
(3, '2025_10_29_070000_create_users_table', 1),
(4, '2025_10_29_070520_create_layanan_table', 1),
(5, '2025_10_29_070534_create_pemesanan_table', 1),
(6, '2025_12_07_201723_create_carts_table', 1),
(7, '2025_12_07_205437_create_products_table', 1),
(8, '2025_12_17_102010_create_pembayaran_table', 1),
(9, '2025_12_07_211723_create_carts_table', 2),
(10, '2025_12_21_121402_create_sessions_table', 2),
(11, '2025_12_21_203359_update_pemesanan_table_change_layanan_to_product', 3),
(12, '2025_12_21_214924_add_payment_columns_to_pemesanan_table', 3),
(13, '2025_12_21_221240_update_pemesanan_table_structure', 4),
(14, '2025_12_22_003649_add_quantity_table_carts', 5),
(15, '2025_12_22_004534_add_product_id_to_table_carts', 6),
(16, '2025_12_22_005800_add_id_to_carts_table', 7);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id` bigint UNSIGNED NOT NULL,
  `pemesanan_id` bigint UNSIGNED NOT NULL,
  `nama_pembayar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_handphone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `waktu_bayar` datetime NOT NULL,
  `total_bayar` decimal(10,2) NOT NULL,
  `metode_pembayaran` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pemesanan`
--

CREATE TABLE `pemesanan` (
  `id` bigint UNSIGNED NOT NULL,
  `order_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` enum('unpaid','pending','paid','failed','expired','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `metode_pembayaran` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status_pembayaran` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `user_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED DEFAULT NULL,
  `tanggal_booking` date NOT NULL,
  `status` enum('pending','proses','selesai','dibatalkan') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `catatan` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `pemesanan`
--

INSERT INTO `pemesanan` (`id`, `order_id`, `total_amount`, `payment_method`, `payment_status`, `metode_pembayaran`, `status_pembayaran`, `user_id`, `product_id`, `tanggal_booking`, `status`, `catatan`, `created_at`, `updated_at`) VALUES
(38, NULL, 20000.00, NULL, 'unpaid', NULL, 'pending', 6, 1, '2026-03-14', 'pending', 'Checkout dari cart - Foto Box Gray - 10 Menit (x1)', '2026-03-11 00:12:55', '2026-03-11 00:12:55'),
(39, NULL, 25000.00, NULL, 'unpaid', NULL, 'pending', 6, 2, '2026-03-14', 'pending', 'Checkout dari cart - Cetak + Bingkai 4R (x1)', '2026-03-11 00:13:54', '2026-03-11 00:13:54');

-- --------------------------------------------------------

--
-- Struktur dari tabel `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga` int NOT NULL,
  `durasi` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kategori` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stok` int NOT NULL,
  `gambar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `products`
--

INSERT INTO `products` (`id`, `nama`, `deskripsi`, `harga`, `durasi`, `kategori`, `stok`, `gambar`, `created_at`, `updated_at`) VALUES
(1, 'Foto Box Gray - 10 Menit', 'Background abu-abu netral cocok buat foto profesional atau casual.', 20000, '10 Menit', 'self_photo', 100, 'bg.gray.jpg', '2025-12-20 14:10:34', '2025-12-21 12:13:41'),
(2, 'Foto Box Gray - 15 Menit', 'Background abu-abu netral cocok buat foto profesional atau casual.', 25000, '15 Menit', 'self_photo', 100, 'bg.gray.jpg', '2025-12-20 14:10:34', '2025-12-20 14:10:34'),
(3, 'Foto Box Silver - 10 Menit', 'Background silver elegan dengan pantulan cahaya lembut.', 20000, '10 Menit', 'self_photo', 100, 'bg.silver.jpg', '2025-12-20 14:10:34', '2025-12-21 19:05:51'),
(4, 'Foto Box Silver - 15 Menit', 'Background silver elegan dengan pantulan cahaya lembut.', 25000, '15 Menit', 'self_photo', 100, 'bg.silver.jpg', '2025-12-20 14:10:34', '2025-12-20 14:10:34'),
(5, 'Background Kayu - 10 Menit', 'Nuansa hangat dan natural, pas buat foto couple atau keluarga.', 20000, '10 Menit', 'self_photo', 100, 'bg.kayu.jpg', '2025-12-20 14:10:34', '2025-12-21 19:11:31'),
(6, 'Background Kayu - 15 Menit', 'Nuansa hangat dan natural, pas buat foto couple atau keluarga.', 25000, '15 Menit', 'self_photo', 100, 'bg.kayu.jpg', '2025-12-20 14:10:34', '2025-12-20 14:10:34'),
(7, 'Background Hitam - 10 Menit', 'Background hitam pekat yang memberi kesan classy dan fokus ke wajah.', 20000, '10 Menit', 'self_photo', 100, 'bg.hitam.jpg', '2025-12-20 14:10:34', '2025-12-20 14:10:34'),
(8, 'Background Hitam - 15 Menit', 'Background hitam pekat yang memberi kesan classy dan fokus ke wajah.', 25000, '15 Menit', 'self_photo', 100, 'bg.hitam.jpg', '2025-12-20 14:10:34', '2025-12-20 14:10:34'),
(9, 'Background Roll - 10 Menit', 'Tersedia beberapa warna roll, bisa pilih sesuai tema kamu.', 20000, '10 Menit', 'self_photo', 100, 'bg.roll.jpg', '2025-12-20 14:10:34', '2025-12-20 14:10:34'),
(10, 'Background Roll - 15 Menit', 'Tersedia beberapa warna roll, bisa pilih sesuai tema kamu.', 25000, '15 Menit', 'self_photo', 100, 'bg.roll.jpg', '2025-12-20 14:10:34', '2025-12-20 14:10:34'),
(11, 'Background Abstract - 10 Menit', 'Cocok buat gaya foto modern dan artsy.', 20000, '10 Menit', 'self_photo', 100, 'bg.abstract.jpg', '2025-12-20 14:10:34', '2025-12-20 14:10:34'),
(12, 'Background Abstract - 15 Menit', 'Cocok buat gaya foto modern dan artsy.', 25000, '15 Menit', 'self_photo', 100, 'bg.abstract.jpg', '2025-12-20 14:10:34', '2025-12-20 14:10:34'),
(13, 'Upgrade Size', 'Buat ukuran yearbook kamu jadi lebih besar. Ingin yearbook yang lebih eye-catching dan berkesan? Upgrade ukuran buku Anda untuk memberikan lebih banyak ruang foto, kenangan, dan cerita bersama teman seangkatan.', -1, '-', 'yearbook_upgrade', 100, 'up.size.jpg', '2025-12-20 15:57:42', '2025-12-20 15:57:42'),
(14, 'Upgrade Paper', 'Kertas lebih tebal & premium buat hasil cetak halus. Meningkatkan kualitas cetak dengan kertas art paper atau matte paper premium. Hasil foto lebih tajam, warna lebih hidup, dan tekstur yang memberikan kesan mewah saat disentuh.', -1, '-', 'yearbook_upgrade', 100, 'up.paper.jpg', '2025-12-20 15:57:42', '2025-12-20 15:57:42'),
(15, 'Upgrade Cover', 'Tampilan cover jadi makin elegan & tahan lama. Pilihan cover hardcover dengan laminasi doff/glossy, emboss logo, atau bahan kulit sintetis. Memberikan perlindungan ekstra untuk buku kenangan Anda sekaligus meningkatkan nilai estetika tampilan luar.', -1, '-', 'yearbook_upgrade', 100, 'up.cover.jpg', '2025-12-20 15:57:42', '2025-12-20 15:57:42'),
(16, 'Upgrade Packaging', 'Biar hasil cetaknya tampil lebih eksklusif. Dilengkapi dengan kotak khusus, wrapping premium, atau pouch eksklusif untuk melindungi yearbook Anda. Cocok sebagai hadiah kelulusan yang berkesan dengan presentasi yang memukau.', -1, '-', 'yearbook_upgrade', 100, 'up.packaging.jpg', '2025-12-20 15:57:42', '2025-12-20 15:57:42'),
(17, 'Medali Logam', 'Bahan logam elegan, cocok buat kenang-kenangan kelulusan. Medali dengan finishing chrome atau gold/silver plating, dilengkapi pita warna resmi institusi. Desain custom dengan detail engraving yang halus, menjadi simbol prestasi dan kebanggaan kelulusan.', 40000, '-', 'yearbook_exclusive', 100, 'mdl.logam.jpg', '2025-12-20 15:57:42', '2025-12-20 15:57:42'),
(18, 'Medali Akrilik', 'Ringan & lucu buat tambahan hadiah wisuda. Medali transparan atau berwarna dengan laser cutting yang presisi. Desain modern dan colorful, bisa dikustomisasi dengan karakter atau quote favorit angkatan Anda.', 15000, '-', 'yearbook_exclusive', 100, 'mdl.akrilik.jpg', '2025-12-20 15:57:42', '2025-12-20 15:57:42'),
(19, 'Foto Hologram', 'Efek berkilau yang unik & beda dari yang lain. Foto dengan efek hologram 3D yang menciptakan ilusi visual menarik ketika dilihat dari berbagai sudut. Teknisi printing khusus yang membuat foto Anda tampil hidup dengan dimensi yang menakjubkan.', 15000, '-', 'yearbook_exclusive', 100, 'foto-hologram.jpg', '2025-12-20 15:57:42', '2025-12-20 15:57:42'),
(20, 'Plakat Foto Akrilik', 'Tampil mewah & eksklusif buat pajangan. Plakat akrilik dengan ketebalan 3-5mm, foto dicetak langsung pada material akrilik untuk hasil yang tajam dan tahan lama. Dilengkapi stand display yang elegan untuk pajangan meja atau dinding.', 35000, '-', 'yearbook_exclusive', 100, 'plakat-akrilik.jpg', '2025-12-20 15:57:42', '2025-12-20 15:57:42'),
(21, 'Totebag Premium Kanvas', 'Totebag tebal & estetik buat bawa yearbook kamu. Terbuat dari kanvas berkualitas dengan handle yang kokoh, dilengkapi desain khusus angkatan Anda. Tidak hanya praktis untuk membawa yearbook, tetapi juga menjadi fashion statement yang stylish untuk sehari-hari.', 20000, '-', 'yearbook_additional', 100, 'totebag.jpg', '2025-12-20 15:57:42', '2025-12-20 15:57:42'),
(22, 'Cetak Foto Wisuda', 'Buat kenang-kenangan momen spesialmu. Cetak foto wisuda favorit Anda dalam berbagai ukuran, mulai dari 4R hingga 16RP. Menggunakan teknologi cetak high-resolution untuk mempertahankan kejernihan dan warna foto momen berharga Anda.', 5000, '-', 'yearbook_additional', 100, 'foto-wisuda.jpg', '2025-12-20 15:57:42', '2025-12-20 15:57:42'),
(23, 'Stiker Angkatan', 'Hiasan kecil tapi manis buat tiap buku. Stiker vinyl dengan desain logo atau karakter angkatan, bisa ditempel di yearbook, laptop, atau botol minum. Kualitas tahan air dan tidak mudah luntur, menjadi reminder kecil yang menggemaskan.', 3000, '-', 'yearbook_additional', 100, 'stiker.jpg', '2025-12-20 15:57:42', '2025-12-20 15:57:42'),
(24, 'Topi Angkatan', 'Biar tampil makin kompak sama temen seangkatan. Topi snapback atau dad cap dengan bordir logo angkatan yang rapi. Bahan breathable untuk kenyamanan maksimal, perfect untuk foto bersama atau digunakan sehari-hari sebagai identitas kebersamaan.', 17000, '-', 'yearbook_additional', 100, 'topi.jpg', '2025-12-20 15:57:42', '2025-12-20 15:57:42'),
(25, 'Kebaya + Kain', 'Buat kamu yang mau tampil anggun di hasil foto. Pilihan kain berkualitas dengan motif tradisional yang elegan. Cocok untuk foto prewedding, wisuda, atau acara formal lainnya.', 25000, '-', 'rental_property', 100, 'kebaya.kain.jpeg', '2025-12-20 16:19:56', '2025-12-20 16:19:56'),
(26, 'Kostum Adat Jawa', 'Vibes-nya klasik banget buat foto adat yang berkesan. Setelan lengkap adat Jawa tradisional. Dilengkapi dengan berbagai aksesori pendukung untuk tampilan yang autentik.', 50000, '-', 'rental_property', 100, 'rp.kojawa.jpg', '2025-12-20 16:19:56', '2025-12-20 16:19:56'),
(27, 'Aksesoris Kecil', 'Pelengkap outfit biar hasil foto makin cantik. Pilihan beragam untuk menyesuaikan dengan tema foto.', 0, '-', 'rental_property', 100, 'aksesoris.jpg', '2025-12-20 16:19:56', '2025-12-20 16:19:56'),
(28, 'Jas', 'Buat look formal yang rapi & elegan. Jas berkualitas dengan potongan modern. Cocok untuk penampilan profesional yang memukau.', 25000, '-', 'rental_property', 100, 'rp.jas.jpg', '2025-12-20 16:19:56', '2025-12-20 16:19:56'),
(29, 'Only Cetak 4R', 'Ukuran standar buat cetak photomu. Cocok untuk koleksi album, kenangan sehari-hari, atau bagi-bagi foto ke keluarga dan teman.', 7000, '-', 'print', 100, 'print.foto.jpg', '2025-12-20 16:24:18', '2025-12-20 16:24:18'),
(30, 'Cetak + Bingkai 4R', 'Cetak foto plus bingkai cantik yang siap dipajang. Praktis dan hemat tanpa perlu cari bingkai terpisah. Cocok untuk meja kerja atau rak kecil.', 25000, '-', 'print', 100, 'print.bingkai.jpg', '2025-12-20 16:24:18', '2025-12-20 16:24:18'),
(31, 'Only Cetak 10RP', 'Ukuran besar buat hasil yang detail. Sempurna untuk foto grup, pemandangan, atau portrait yang ingin ditampilkan lebih hidup.', 30000, '-', 'print', 100, 'print.foto.jpg', '2025-12-20 16:24:18', '2025-12-20 16:24:18'),
(32, 'Cetak + Bingkai 10RP', 'Bingkai besar buat hasil yang mewah. Memberikan sentuhan elegan pada foto keluarga, pernikahan, atau karya seni favoritmu.', 54000, '-', 'print', 100, 'print.bingkai.jpg', '2025-12-20 16:24:18', '2025-12-20 16:24:18'),
(33, 'Only Cetak 12RP', 'Lebih besar & jelas buat dekorasi ruangmu. Ideal untuk foto artis favorit, keluarga besar, atau momen spesial yang layak diperbesar.', 40000, '-', 'print', 100, 'print.foto.jpg', '2025-12-20 16:24:18', '2025-12-20 16:24:18'),
(34, 'Cetak + Bingkai 12RP', 'Tampil elegan dengan bingkai premium. Cocok untuk ruang tamu, kantor, atau sebagai hadiah yang berkelas untuk orang terkasih.', 110000, '-', 'print', 100, 'print.bingkai.jpg', '2025-12-20 16:24:18', '2025-12-20 16:24:18'),
(35, 'Only Cetak 16RP', 'Buat hasil foto yang super jelas & estetik. Pilihan utama untuk pajangan gallery, ruang tamu, atau hadiah istimewa yang berkesan.', 175000, '-', 'print', 100, 'print.foto.jpg', '2025-12-20 16:24:18', '2025-12-20 16:24:18'),
(36, 'Cetak + Bingkai 16RP', 'Ukuran jumbo buat pajangan rumah kamu. Membuat foto jadi focal point ruangan dengan kesan monumental dan tak terlupakan.', 295000, '-', 'print', 100, 'print.bingkai.jpg', '2025-12-20 16:24:18', '2025-12-20 16:24:18'),
(38, 'Foto', 'FOTO', 394, '58', 'yearbook_upgrade', 4239, 'gambar_product/9kfeS60tYvaQ8XVGJH2UROM2UcpQOjaoNb3D70ta.jpg', '2025-12-21 12:50:27', '2025-12-21 13:04:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pelanggan',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `nama`, `email`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(5, 'Erwan Kurniawan', 'erwan@gmail.com', '$2y$12$rU3PhB83Ss7w8Rlo.AQxe.ufWkwuraDSsBcyE8DEbJzUycTjSPxLW', 'pelanggan', NULL, '2025-12-21 13:05:08', '2025-12-21 13:05:08'),
(6, 'Alfath Shafira', 'alfathshafira4@gmail.com', '$2y$12$Kft4zgUENZko28F2vm7Mg.HVLUmPk7AwemdtpAt47utZAY.NMTgdC', 'pelanggan', NULL, '2026-03-11 00:11:15', '2026-03-11 00:11:15');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `carts_product_id_foreign` (`product_id`),
  ADD KEY `carts_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indeks untuk tabel `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pembayaran_pemesanan_id_foreign` (`pemesanan_id`);

--
-- Indeks untuk tabel `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pemesanan_user_id_foreign` (`user_id`),
  ADD KEY `pemesanan_product_id_fk` (`product_id`),
  ADD KEY `pemesanan_order_id_index` (`order_id`),
  ADD KEY `pemesanan_payment_status_index` (`payment_status`);

--
-- Indeks untuk tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pemesanan`
--
ALTER TABLE `pemesanan`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT untuk tabel `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_pemesanan_id_foreign` FOREIGN KEY (`pemesanan_id`) REFERENCES `pemesanan` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD CONSTRAINT `pemesanan_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pemesanan_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
