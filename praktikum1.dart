// =============================================================
// Nama   : Feri Tri Setiawan
// NIM    : 202463121007
// Tugas  : Praktikum Dart Minggu 04 - Soal 1
// Materi : List, class, method iterable (where, map, reduce)
// File   : praktikum_4_1.dart
// =============================================================

/// Model data mahasiswa.
class Mahasiswa {
  final String nama;
  final int nilai;

  const Mahasiswa(this.nama, this.nilai);

  @override
  String toString() => '$nama ($nilai)';
}

/// Batas nilai lulus.
const int batasLulus = 75;

/// Daftar mahasiswa (8 orang).
const List<Mahasiswa> kelas = [
  Mahasiswa('Rain', 88),
  Mahasiswa('Made', 72),
  Mahasiswa('Feri', 95),
  Mahasiswa('Yosni', 64),
  Mahasiswa('Nia', 78),
  Mahasiswa('Okta', 81),
  Mahasiswa('Elvrida', 55),
  Mahasiswa('Virgin', 90),
];

void main() {
  print('========== STATISTIK NILAI KELAS ==========');
  print('Jumlah mahasiswa: ${kelas.length}');
  print('');

  hitungStatistik();
  print('');
  tampilkanYangMengulang();
  print('');
  tampilkanPeringkat();
}

// -------------------------------------------------------------
// Rata-rata, tertinggi, terendah
// -------------------------------------------------------------
void hitungStatistik() {
  // Ambil semua nilai jadi List<int>
  List<int> semuaNilai = kelas.map((m) => m.nilai).toList();

  // Rata-rata: jumlah semua nilai / jumlah mahasiswa
  double rata = semuaNilai.reduce((a, b) => a + b) / semuaNilai.length;

  // Mahasiswa dengan nilai tertinggi
  // reduce membandingkan dua mahasiswa, pilih yang nilainya lebih besar
  Mahasiswa tertinggi = kelas.reduce((a, b) => a.nilai >= b.nilai ? a : b);

  // Mahasiswa dengan nilai terendah
  Mahasiswa terendah = kelas.reduce((a, b) => a.nilai <= b.nilai ? a : b);

  print('--- Statistik ---');
  print('Rata-rata   : ${rata.toStringAsFixed(2)}');
  print('Tertinggi   : ${tertinggi.nama} (${tertinggi.nilai})');
  print('Terendah    : ${terendah.nama} (${terendah.nilai})');
}

// -------------------------------------------------------------
// Daftar nama yang mengulang (nilai < batasLulus)
// -------------------------------------------------------------
void tampilkanYangMengulang() {
  // where: filter mahasiswa yang nilainya di bawah batas lulus
  // map : ambil namanya saja
  // toList: ubah Iterable jadi List agar bisa diurutkan
  List<String> mengulang = kelas
      .where((m) => m.nilai < batasLulus)
      .map((m) => m.nama)
      .toList();

  // Urutkan secara alfabetis (A-Z)
  mengulang.sort();

  print('--- Mahasiswa Mengulang (nilai < $batasLulus) ---');
  if (mengulang.isEmpty) {
    print('Tidak ada yang mengulang.');
  } else {
    for (int i = 0; i < mengulang.length; i++) {
      print('${i + 1}. ${mengulang[i]}');
    }
    print('Total: ${mengulang.length} mahasiswa');
  }
}

// -------------------------------------------------------------
// Peringkat (bonus, dari nilai tertinggi ke terendah)
// -------------------------------------------------------------
void tampilkanPeringkat() {
  // Salin list dulu, jangan ubah list asli
  // [...kelas] membuat list baru yang isinya sama
  List<Mahasiswa> urut = [...kelas]..sort((a, b) => b.nilai.compareTo(a.nilai));

  print('--- Peringkat Kelas ---');
  for (int i = 0; i < urut.length; i++) {
    print('${(i + 1).toString().padLeft(2)}. ${urut[i]}');
  }
}
