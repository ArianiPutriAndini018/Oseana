# OSEANA

OSEANA merupakan aplikasi edukasi biota laut Indonesia yang menggabungkan **QR Code**, **Ocean Journey Map**, **quiz interaktif**, **gamifikasi**, dan **Sea Passport** sebagai media pembelajaran digital. Aplikasi ini dirancang untuk meningkatkan literasi konservasi laut sekaligus mendukung **Sustainable Development Goal (SDG) 14: Life Below Water**.

Melalui OSEANA, pengguna dapat mempelajari biota laut endemik Indonesia dengan cara yang lebih interaktif, menyenangkan, dan mudah dipahami, baik saat berkunjung ke aquarium maupun belajar secara mandiri.

---

# Informasi Proyek

| Komponen      | Keterangan                |
| ------------- | ------------------------- |
| Nama Aplikasi | OSEANA                    |
| Mata Kuliah   | Teknologi Mobile          |
| Program Studi | Sistem Informasi          |
| Universitas   | Universitas Ahmad Dahlan  |
| Tema          | SDG 14 – Life Below Water |
| Kelompok      | BAM!                      |

---

# Tim Pengembang

| Nama                | NIM        | Peran                                               |
| ------------------- | ---------- | --------------------------------------------------- |
| Ariani Putri Andini | 2400016018 | Project Manager, UI/UX Designer, Frontend Developer |
| Meylani             | 2400016012 | Frontend Developer, UI/UX Designer                  |
| Bagus Purboyo       | 2300016116 | Backend Developer                                   |

---

# Latar Belakang

Indonesia merupakan negara kepulauan dengan keanekaragaman hayati laut yang sangat tinggi. Namun, proses edukasi mengenai biota laut masih didominasi oleh media konvensional seperti poster atau papan informasi sehingga pembelajaran menjadi kurang interaktif dan sulit mengukur pemahaman pengguna.

OSEANA dikembangkan sebagai solusi pembelajaran digital yang mengintegrasikan teknologi mobile, QR Code, gamifikasi, dan media interaktif untuk meningkatkan pengalaman belajar sekaligus menumbuhkan kepedulian terhadap konservasi laut.

---

# Analisis 5W + 1H

| Aspek     | Penjelasan                                                                                          |
| --------- | --------------------------------------------------------------------------------------------------- |
| **What**  | Edukasi biota laut masih kurang menarik dan interaktif.                                             |
| **Why**   | Materi sulit menarik perhatian serta mengukur tingkat pemahaman pengguna.                           |
| **Who**   | Pelajar, mahasiswa, guru, keluarga, pengunjung aquarium, museum, dan masyarakat umum.               |
| **Where** | Sekolah, kampus, aquarium, museum, pameran edukasi, maupun pembelajaran mandiri.                    |
| **When**  | Saat kegiatan belajar, field trip, kunjungan edukasi, maupun belajar di rumah.                      |
| **How**   | Melalui QR Code, Ocean Journey Map, quiz interaktif, gamifikasi, Sea Passport, dan misi konservasi. |

---

# Solusi

OSEANA menghadirkan pembelajaran berbasis eksplorasi digital. Pengguna dapat memilih mode belajar, menjelajahi pulau-pulau Indonesia, mempelajari biota laut, mengerjakan quiz, kemudian memperoleh reward berupa XP, Star, Badge, dan Stamp yang tersimpan pada Sea Passport.

Pendekatan ini membuat proses belajar menjadi lebih menarik, terarah, dan mampu meningkatkan keterlibatan pengguna selama proses pembelajaran.

---

# Tujuan

* Mengenalkan biota laut Indonesia secara interaktif.
* Meningkatkan literasi konservasi laut.
* Mendukung implementasi SDG 14 melalui media digital.
* Menjadikan pembelajaran lebih menarik menggunakan gamifikasi.

---

# Sasaran Pengguna

| Pengguna                        | Manfaat                                            |
| ------------------------------- | -------------------------------------------------- |
| Pelajar dan Mahasiswa           | Belajar biota laut dengan media interaktif.        |
| Guru dan Pendamping             | Mendukung kegiatan pembelajaran dan field trip.    |
| Pengunjung Aquarium atau Museum | Mendapatkan pengalaman belajar yang lebih menarik. |
| Masyarakat Umum                 | Meningkatkan kepedulian terhadap konservasi laut.  |

---

# Fitur Utama

| Fitur                | Deskripsi                                                 |
| -------------------- | --------------------------------------------------------- |
| Home                 | Halaman utama aplikasi.                                   |
| Aquarium Mode        | Belajar melalui QR Code yang tersedia pada media edukasi. |
| Explore Mode         | Belajar secara mandiri tanpa QR Code.                     |
| Ocean Journey Map    | Peta perjalanan pembelajaran berbasis pulau.              |
| QR Scanner           | Membuka materi pembelajaran melalui QR Code.              |
| Manual Code          | Alternatif jika QR gagal dipindai.                        |
| Detail Pulau         | Informasi setiap wilayah pembelajaran.                    |
| Detail Biota         | Biodata, habitat, ancaman, fun fact, dan video edukasi.   |
| Quiz                 | Evaluasi pembelajaran setiap pulau.                       |
| Reward               | XP, Star, Stamp, dan Badge.                               |
| Sea Passport         | Menyimpan seluruh progres pengguna.                       |
| Conservation Mission | Pesan dan aksi sederhana untuk menjaga lingkungan laut.   |

---

# Konsep Pembelajaran

OSEANA menggunakan **Ocean Journey Map** sebagai jalur pembelajaran. Pengguna akan menjelajahi wilayah Indonesia secara bertahap.

Wilayah yang tersedia:

1. NTT
2. NTB
3. Jawa
4. Sumatera
5. Kalimantan
6. Sulawesi
7. Papua

Setiap wilayah terdiri dari:

* Maksimal 3 biota laut
* Materi edukasi
* Video pembelajaran
* Quiz
* Reward
* Stamp Pulau

---

# Alur Penggunaan

```text
Home
│
├── Aquarium Mode
│      ├── Scan QR
│      ├── Detail Pulau
│      ├── Detail Biota
│      ├── Quiz
│      ├── Reward
│      └── Sea Passport
│
└── Explore Mode
       ├── Ocean Journey Map
       ├── Pilih Pulau
       ├── Detail Biota
       ├── Quiz
       ├── Reward
       └── Sea Passport
```

---

# Arsitektur Sistem

```text
Mobile Application (Flutter)
          │
QR Scanner / Manual Code
          │
API / JSON
          │
Database
          │
──────────────────────────────
• Detail Pulau
• Detail Biota
• Quiz
• Video Edukasi
• Reward
• Sea Passport
• Badge
```

---

# Alur Kerja Sistem

```text
Pilih Mode Belajar
        │
Scan QR / Pilih Pulau
        │
Pelajari Biota
        │
Quiz
        │
Hitung Skor
        │
Reward
        │
Sea Passport
        │
Level Berikutnya Terbuka
```

---

# Input – Process – Output

| Input                      | Process                                                                     | Output                                                                               |
| -------------------------- | --------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| Scan QR atau memilih pulau | Sistem membuka materi, menghitung skor quiz, dan menyimpan progres pengguna | Detail biota, skor quiz, XP, Star, Stamp, Sea Passport, dan level berikutnya terbuka |

---

# Teknologi

| Teknologi  | Fungsi               |
| ---------- | -------------------- |
| Flutter    | Mobile Development   |
| Dart       | Bahasa Pemrograman   |
| Supabase   | Backend dan Database |
| QR Scanner | Pemindaian QR Code   |
| Figma      | Perancangan UI/UX    |
| GitHub     | Version Control      |

---

# Struktur Project

```text
oseana/
├── assets/
├── lib/
│   ├── models/
│   ├── pages/
│   ├── services/
│   ├── widgets/
│   └── main.dart
├── docs/
├── README.md
└── pubspec.yaml
```

---

# Kontribusi terhadap SDGs

OSEANA mendukung **Sustainable Development Goal (SDG) 14 – Life Below Water** melalui media pembelajaran digital yang bertujuan meningkatkan literasi mengenai biota laut Indonesia, menumbuhkan kepedulian terhadap konservasi laut, serta mendorong masyarakat untuk menjaga kelestarian ekosistem laut.

---

# Kesimpulan

OSEANA menghadirkan pengalaman belajar biota laut yang lebih interaktif melalui QR Code, Ocean Journey Map, quiz, gamifikasi, dan Sea Passport. Dengan pendekatan tersebut, aplikasi ini diharapkan mampu meningkatkan literasi konservasi laut sekaligus menjadi media pembelajaran digital yang mendukung implementasi SDG 14 di Indonesia.

---
