# Katalog Produk Flutter (api_app)

Aplikasi katalog produk sederhana menggunakan [DummyJSON API](https://dummyjson.com/).

## Fitur
- Menampilkan daftar produk (GridView 2 kolom).
- Pencarian produk dengan debounce 500ms.
- Pull-to-refresh untuk memuat ulang data.
- Detail produk dengan informasi lengkap.
- Penanganan error dan state loading.

## Teknis
- Flutter 3.47.6
- HTTP sebagai satu-satunya dependency pihak ketiga.
- State Management: `StatefulWidget`, `FutureBuilder`, `setState`.

## Instalasi
1. Pastikan Flutter SDK sudah terinstal.
2. Jalankan aplikasi:
   ```bash
   flutter run
   ```

## Struktur File
- `lib/main.dart`: Entry point.
- `lib/models/product.dart`: Model data produk.
- `lib/services/api_service.dart`: Integrasi API.
- `lib/pages/`: Halaman List dan Detail.
- `lib/widgets/`: Komponen UI (ErrorView).
