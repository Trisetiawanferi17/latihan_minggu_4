// =============================================================
// Nama   : Feri Tri Setiawan
// NIM    : 202463121007
// Tugas  : Pengolah Data Akademik
// Materi : List<Map>, method iterable (where, map, sort, any, every)
// File   : tugas_akademik.dart
// =============================================================

void main() {
  // ===== Data mata kuliah =====
  // List<Map<String, dynamic>> artinya: list berisi map dengan
  // kunci String dan nilai bertipe bebas (String, int, dsb).
  List<Map<String, dynamic>> mataKuliah = [
    {
      'nama': 'Pemrograman Mobile',
      'sks': 3,
      'dosen': 'Pak Agung',
      'semester': 4,
    },
    {'nama': 'Basis Data', 'sks': 3, 'dosen': 'Bu Sari', 'semester': 3},
    {'nama': 'Jaringan Komputer', 'sks': 3, 'dosen': 'Pak Budi', 'semester': 4},
    {
      'nama': 'Algoritma dan Struktur Data',
      'sks': 4,
      'dosen': 'Pak Wira',
      'semester': 2,
    },
    {
      'nama': 'Kecerdasan Buatan',
      'sks': 3,
      'dosen': 'Pak Surya',
      'semester': 5,
    },
    {
      'nama': 'Praktikum Basis Data',
      'sks': 1,
      'dosen': 'Pak Agus',
      'semester': 3,
    },
    {
      'nama': 'Praktikum Pemrograman Mobile',
      'sks': 1,
      'dosen': 'Pak Agung',
      'semester': 4,
    },
    {'nama': 'Sistem Operasi', 'sks': 3, 'dosen': 'Pak Adi', 'semester': 3},
    {
      'nama': 'Interaksi Manusia dan Komputer',
      'sks': 2,
      'dosen': 'Pak Angga',
      'semester': 5,
    },
  ];

  print('========== PENGOLAH DATA AKADEMIK ==========');
  print('Total mata kuliah: ${mataKuliah.length}\n');

  // ===== 1. Pencarian berdasarkan kata kunci =====
  print('===== 1. Pencarian dengan kata kunci "basis" =====');
  cetakDaftar(cariKataKunci(mataKuliah, 'basis'));

  print('\n===== Pencarian dengan kata kunci "Praktikum" =====');
  cetakDaftar(cariKataKunci(mataKuliah, 'praktikum'));

  print('\n===== Pencarian tanpa hasil (kata "kalkulus") =====');
  cetakDaftar(cariKataKunci(mataKuliah, 'kalkulus'));

  // ===== 2. Penyaringan berdasarkan SKS =====
  print('\n===== 2. Mata kuliah dengan SKS = 3 =====');
  cetakDaftar(filterSks(mataKuliah, 3));

  print('\n===== Mata kuliah dengan SKS >= 3 =====');
  cetakDaftar(filterSksMinimal(mataKuliah, 3));

  print('\n===== Mata kuliah dengan SKS < 3 =====');
  cetakDaftar(filterSksMaksimal(mataKuliah, 2));

  // ===== 3. Pengurutan berdasarkan nama =====
  print('\n===== 3. Urut berdasarkan nama (A-Z) =====');
  cetakDaftar(urutkanBerdasarkanNama(mataKuliah));

  print('\n===== Urut berdasarkan SKS (terbesar ke terkecil) =====');
  cetakDaftar(urutkanBerdasarkanSks(mataKuliah));

  // ===== 4. Ringkasan tambahan =====
  print('\n===== 4. Ringkasan =====');
  tampilkanRingkasan(mataKuliah);
}

// =============================================================
// 1. PENCARIAN BERDASARKAN KATA KUNCI
// =============================================================
//
// Memakai:
//   - where  : filter item yang namanya mengandung kata kunci
//   - toLowerCase : agar pencarian tidak peduli huruf besar/kecil
//   - contains : cek apakah String mengandung substring
List<Map<String, dynamic>> cariKataKunci(
  List<Map<String, dynamic>> data,
  String kataKunci,
) {
  String kunci = kataKunci.toLowerCase();
  return data
      .where((mk) => mk['nama'].toString().toLowerCase().contains(kunci))
      .toList();
}

// =============================================================
// 2. PENYARINGAN BERDASARKAN SKS
// =============================================================
//
// Memakai:
//   - where  : filter item dengan SKS sesuai kriteria
//   - toList : ubah Iterable menjadi List

/// Filter SKS tepat sama dengan nilai tertentu.
List<Map<String, dynamic>> filterSks(List<Map<String, dynamic>> data, int sks) {
  return data.where((mk) => mk['sks'] == sks).toList();
}

/// Filter SKS minimal (>= nilai tertentu).
List<Map<String, dynamic>> filterSksMinimal(
  List<Map<String, dynamic>> data,
  int minimal,
) {
  return data.where((mk) => (mk['sks'] as int) >= minimal).toList();
}

/// Filter SKS maksimal (<= nilai tertentu).
List<Map<String, dynamic>> filterSksMaksimal(
  List<Map<String, dynamic>> data,
  int maksimal,
) {
  return data.where((mk) => (mk['sks'] as int) <= maksimal).toList();
}

// =============================================================
// 3. PENGURUTAN
// =============================================================
//
// Memakai:
//   - [...data] : salin dulu supaya list asli tidak ikut terurut
//   - sort      : urutkan berdasarkan pembanding
//   - compareTo : bandingkan dua nilai
List<Map<String, dynamic>> urutkanBerdasarkanNama(
  List<Map<String, dynamic>> data,
) {
  // Salin list dulu, jangan ubah list asli
  List<Map<String, dynamic>> salinan = [...data];
  salinan.sort((a, b) => a['nama'].toString().compareTo(b['nama'].toString()));
  return salinan;
}

List<Map<String, dynamic>> urutkanBerdasarkanSks(
  List<Map<String, dynamic>> data,
) {
  List<Map<String, dynamic>> salinan = [...data];
  // Urut menurun: b dibanding a
  salinan.sort((a, b) => (b['sks'] as int).compareTo(a['sks'] as int));
  return salinan;
}

// =============================================================
// 4. RINGKASAN (bonus, semua pakai method iterable)
// =============================================================
void tampilkanRingkasan(List<Map<String, dynamic>> data) {
  // Total SKS: map untuk ambil SKS, reduce untuk jumlahkan
  int totalSks = data.map((mk) => mk['sks'] as int).reduce((a, b) => a + b);

  // Rata-rata SKS per mata kuliah
  double rata = totalSks / data.length;

  // Dosen unik: map nama dosen, ubah ke Set agar unik, kembali ke List
  List<String> daftarDosen =
      data.map((mk) => mk['dosen'].toString()).toSet().toList()..sort();

  // Mata kuliah dengan SKS terbesar
  Map<String, dynamic> sksTerbesar = data.reduce(
    (a, b) => (a['sks'] as int) >= (b['sks'] as int) ? a : b,
  );

  // Ada mata kuliah SKS 4?
  bool adaSks4 = data.any((mk) => mk['sks'] == 4);

  // Semua mata kuliah minimal 1 SKS?
  bool semuaMinimal1 = data.every((mk) => (mk['sks'] as int) >= 1);

  print('Total SKS keseluruhan    : $totalSks');
  print('Rata-rata SKS per MK     : ${rata.toStringAsFixed(2)}');
  print('Jumlah dosen unik        : ${daftarDosen.length}');
  print('Daftar dosen             : ${daftarDosen.join(", ")}');
  print(
    'MK dengan SKS terbesar   : ${sksTerbesar['nama']} '
    '(${sksTerbesar['sks']} SKS)',
  );
  print('Ada MK dengan SKS 4?     : $adaSks4');
  print('Semua MK minimal 1 SKS?  : $semuaMinimal1');
}

// =============================================================
// Fungsi bantu: cetak daftar
// =============================================================
//
// Catatan: fungsi ini boleh memakai forEach (method iterable)
// untuk menampilkan, bukan perulangan manual.
void cetakDaftar(List<Map<String, dynamic>> data) {
  if (data.isEmpty) {
    print('  (tidak ada data)');
    return;
  }

  data.asMap().forEach((index, mk) {
    print(
      '  ${(index + 1).toString().padLeft(2)}. '
      '${mk['nama'].toString().padRight(35)} '
      '| ${mk['sks']} SKS '
      '| ${mk['dosen']} '
      '| Semester ${mk['semester']}',
    );
  });

  print('  Total: ${data.length} mata kuliah');
}
