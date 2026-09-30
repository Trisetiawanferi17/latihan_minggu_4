// =============================================================
// Nama   : Feri Tri Setiawan
// NIM    : 202463121007
// Tugas  : Praktikum Dart Minggu 04 - Soal 2
// Materi : Map, CRUD, filter dengan where pada entries
// File   : praktikum_4_2.dart
// =============================================================

void main() {
  print('========== MAP INVENTARIS ==========');

  // ===== 1. Buat Map awal =====
  // Map<String, int> -> kunci: nama barang (String),
  //                     nilai: jumlah stok (int)
  Map<String, int> inventaris = {
    'Beras': 10,
    'Gula': 4,
    'Minyak': 3,
    'Telur': 12,
    'Tepung': 2,
    'Kecap': 8,
    'Garam': 1,
  };

  print('\n--- Inventaris Awal ---');
  tampilkanInventaris(inventaris);

  // ===== 2. TAMBAH satu item baru =====
  // Kalau kunci belum ada, otomatis ditambahkan.
  print('\n--- TAMBAH: Sabun (6) ---');
  inventaris['Sabun'] = 6;
  tampilkanInventaris(inventaris);

  // ===== 3. UBAH satu item =====
  // Kalau kunci sudah ada, nilainya ditimpa.
  print('\n--- UBAH: Beras dari 10 menjadi 25 ---');
  inventaris['Beras'] = 25;
  tampilkanInventaris(inventaris);

  // ===== 4. HAPUS satu item =====
  // remove() mengembalikan nilai yang dihapus (atau null kalau tidak ada).
  print('\n--- HAPUS: Kecap ---');
  int? nilaiDihapus = inventaris.remove('Kecap');
  print('Nilai yang dihapus: $nilaiDihapus');
  tampilkanInventaris(inventaris);

  // ===== 5. Tampilkan barang dengan stok < 5 =====
  print('\n--- Barang dengan stok di bawah 5 ---');
  tampilkanStokRendah(inventaris, batas: 5);

  // ===== Ringkasan =====
  print('\n--- Ringkasan ---');
  print('Jumlah jenis barang : ${inventaris.length}');
  print('Total stok          : ${hitungTotalStok(inventaris)}');
  print('Barang paling banyak: ${cariStokTerbanyak(inventaris)}');
  print('Barang paling sedikit: ${cariStokTersedikit(inventaris)}');
}

// -------------------------------------------------------------
// Menampilkan seluruh isi inventaris
// -------------------------------------------------------------
void tampilkanInventaris(Map<String, int> inventaris) {
  if (inventaris.isEmpty) {
    print('(inventaris kosong)');
    return;
  }

  // entries -> daftar pasangan (key, value)
  // forEach -> iterasi tiap pasangan
  inventaris.forEach((nama, stok) {
    print('  ${nama.padRight(10)} : $stok');
  });
}

// -------------------------------------------------------------
// Filter barang dengan stok di bawah batas
// -------------------------------------------------------------
//
// where dipakai pada `inventaris.entries` karena:
//   - entry punya key (nama barang) -> untuk ditampilkan
//   - entry punya value (stok)      -> untuk dibandingkan
//
// Hasil where adalah Iterable<MapEntry>, kita tampilkan satu-satu.
void tampilkanStokRendah(Map<String, int> inventaris, {int batas = 5}) {
  // where mengembalikan Iterable<MapEntry<String, int>>
  Iterable<MapEntry<String, int>> stokRendah = inventaris.entries.where(
    (entry) => entry.value < batas,
  );

  // Ubah jadi List supaya bisa diurutkan dan dihitung panjangnya
  List<MapEntry<String, int>> hasil = stokRendah.toList();

  if (hasil.isEmpty) {
    print('  Tidak ada barang dengan stok di bawah $batas.');
    return;
  }

  // Urutkan dari stok paling sedikit ke paling banyak
  hasil.sort((a, b) => a.value.compareTo(b.value));

  for (var entry in hasil) {
    print('  ${entry.key.padRight(10)} : ${entry.value} (perlu restok)');
  }

  print('  Total: ${hasil.length} barang perlu restok');
}

// -------------------------------------------------------------
// Fungsi bantu untuk ringkasan
// -------------------------------------------------------------
int hitungTotalStok(Map<String, int> inventaris) {
  // values -> Iterable<int> berisi semua stok
  return inventaris.values.reduce((a, b) => a + b);
}

String cariStokTerbanyak(Map<String, int> inventaris) {
  // entries.reduce membandingkan dua pasangan
  MapEntry<String, int> teratas = inventaris.entries.reduce(
    (a, b) => a.value >= b.value ? a : b,
  );
  return '${teratas.key} (${teratas.value})';
}

String cariStokTersedikit(Map<String, int> inventaris) {
  MapEntry<String, int> terbawah = inventaris.entries.reduce(
    (a, b) => a.value <= b.value ? a : b,
  );
  return '${terbawah.key} (${terbawah.value})';
}
