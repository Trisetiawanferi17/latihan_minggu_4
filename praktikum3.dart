// =============================================================
// Nama   : Feri Tri Setiawan
// NIM    : 202463121007
// Tugas  : Praktikum Dart Minggu 04 - Soal 3
// Materi : Higher-order function
// File   : praktikum_4_3.dart
// =============================================================

/// Model data untuk latihan.
class Mahasiswa {
  final String nama;
  final int nilai;
  final String prodi;

  const Mahasiswa(this.nama, this.nilai, this.prodi);

  @override
  String toString() => '$nama ($nilai, $prodi)';
}

void main() {
  const List<Mahasiswa> data = [
    Mahasiswa('Rain', 88, 'Teknik Komputer'),
    Mahasiswa('Made', 72, 'Sistem Informasi'),
    Mahasiswa('Feri', 95, 'Teknik Komputer'),
    Mahasiswa('Dewa', 64, 'Teknik Komputer'),
    Mahasiswa('Eka', 78, 'Sistem Informasi'),
    Mahasiswa('Fajar', 81, 'Teknik Komputer'),
    Mahasiswa('Gita', 55, 'Sistem Informasi'),
    Mahasiswa('Elvrida', 90, 'Teknik Komputer'),
  ];

  print('========== PRAKTIKUM 3: HIGHER-ORDER FUNCTION ==========');
  print('Total data: ${data.length} mahasiswa\n');

  // =========================================================
  // BAGIAN A — Versi higher-order function
  // =========================================================
  print('===== A. Versi Higher-Order Function =====\n');

  // Kriteria 1: nilai >= 75 (lulus)
  var lulus = filterData(data, (m) => m.nilai >= 75);
  print('1. Mahasiswa lulus (nilai >= 75):');
  cetakDaftar(lulus);

  // Kriteria 2: dari prodi Teknik Komputer
  var tik = filterData(data, (m) => m.prodi == 'Teknik Komputer');
  print('\n2. Mahasiswa prodi Teknik Komputer:');
  cetakDaftar(tik);

  // Kriteria 3: nama berawalan huruf A-E (alfabetis awal)
  var namaAwal = filterData(
    data,
    (m) => m.nama.codeUnitAt(0) <= 'E'.codeUnitAt(0),
  );
  print('\n3. Mahasiswa dengan nama berawalan A-E:');
  cetakDaftar(namaAwal);

  // Kriteria 4 (bonus): nilai ganjil
  var nilaiGanjil = filterData(data, (m) => m.nilai.isOdd);
  print('\n4. Mahasiswa dengan nilai ganjil:');
  cetakDaftar(nilaiGanjil);

  // =========================================================
  // BAGIAN B — Versi perulangan biasa (tanpa higher-order)
  // =========================================================
  print('\n===== B. Versi Perulangan Biasa =====\n');

  var lulusV2 = filterLulus(data);
  print('1. Mahasiswa lulus (nilai >= 75):');
  cetakDaftar(lulusV2);

  var tikV2 = filterProdiTik(data);
  print('\n2. Mahasiswa prodi Teknik Komputer:');
  cetakDaftar(tikV2);

  var namaAwalV2 = filterNamaAwalAE(data);
  print('\n3. Mahasiswa dengan nama berawalan A-E:');
  cetakDaftar(namaAwalV2);

  // Bandingkan hasilnya: harus identik dengan versi A
  print('\n===== C. Verifikasi Hasil Sama =====');
  print('Kriteria 1 sama? ${_bandingkan(lulus, lulusV2)}');
  print('Kriteria 2 sama? ${_bandingkan(tik, tikV2)}');
  print('Kriteria 3 sama? ${_bandingkan(namaAwal, namaAwalV2)}');
}

// =============================================================
// BAGIAN A — Higher-order function
// =============================================================
//
// filterData menerima:
//   - data     : List<Mahasiswa> yang akan difilter
//   - kriteria : sebuah function yang menerima Mahasiswa
//                dan mengembalikan bool
//
// Function seperti ini disebut PREDICATE.
// Pemanggil bebas menentukan kriteria apa pun tanpa
// mengubah isi filterData sendiri.

List<Mahasiswa> filterData(
  List<Mahasiswa> data,
  bool Function(Mahasiswa) kriteria,
) {
  List<Mahasiswa> hasil = [];
  for (final m in data) {
    if (kriteria(m)) {
      hasil.add(m);
    }
  }
  return hasil;
}

// =============================================================
// BAGIAN B — Versi perulangan biasa (hardcoded)
// =============================================================
//
// Setiap kriteria butuh function sendiri. Kalau ada 10 kriteria,
// kita butuh 10 function berbeda — meskipun logikanya sama
// (iterasi + if + add). Ini yang disebut "duplikasi kode".

List<Mahasiswa> filterLulus(List<Mahasiswa> data) {
  List<Mahasiswa> hasil = [];
  for (final m in data) {
    if (m.nilai >= 75) {
      hasil.add(m);
    }
  }
  return hasil;
}

List<Mahasiswa> filterProdiTik(List<Mahasiswa> data) {
  List<Mahasiswa> hasil = [];
  for (final m in data) {
    if (m.prodi == 'Teknik Komputer') {
      hasil.add(m);
    }
  }
  return hasil;
}

List<Mahasiswa> filterNamaAwalAE(List<Mahasiswa> data) {
  List<Mahasiswa> hasil = [];
  for (final m in data) {
    if (m.nama.codeUnitAt(0) <= 'E'.codeUnitAt(0)) {
      hasil.add(m);
    }
  }
  return hasil;
}

// =============================================================
// Fungsi bantu
// =============================================================

void cetakDaftar(List<Mahasiswa> data) {
  if (data.isEmpty) {
    print('  (kosong)');
    return;
  }
  for (int i = 0; i < data.length; i++) {
    print('  ${i + 1}. ${data[i]}');
  }
  print('  Total: ${data.length}');
}

/// Bandingkan dua list mahasiswa, kembalikan true kalau isinya sama.
bool _bandingkan(List<Mahasiswa> a, List<Mahasiswa> b) {
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i].nama != b[i].nama) return false;
  }
  return true;
}
