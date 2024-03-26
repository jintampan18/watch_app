# FLutter TV Series Tugas Dicoding Flutter Developer Expert

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

[![Codemagic build status](https://api.codemagic.io/apps/6602fbaf131d3b70ba95c92c/release-workflow/status_badge.svg)](https://codemagic.io/apps/6602fbaf131d3b70ba95c92c/release-workflow/latest_build)

## a199-flutter-expert-project

Repository ini merupakan starter project submission kelas Flutter Expert Dicoding Indonesia.

---

## Tips Submission Awal

Pastikan untuk memeriksa kembali seluruh hasil testing pada submissionmu sebelum dikirimkan. Karena kriteria pada submission ini akan diperiksa setelah seluruh berkas testing berhasil dijalankan.

## Tips Submission Akhir

Jika kamu menerapkan modular pada project, Anda dapat memanfaatkan berkas `test.sh` pada repository ini. Berkas tersebut dapat mempermudah proses testing melalui _terminal_ atau _command prompt_. Sebelumnya menjalankan berkas tersebut, ikuti beberapa langkah berikut:

1. Install terlebih dahulu aplikasi sesuai dengan Operating System (OS) yang Anda gunakan.

   - Bagi pengguna **Linux**, jalankan perintah berikut pada terminal.

     ```
     sudo apt-get update -qq -y
     sudo apt-get install lcov -y
     ```

   - Bagi pengguna **Mac**, jalankan perintah berikut pada terminal.
     ```
     brew install lcov
     ```
   - Bagi pengguna **Windows**, ikuti langkah berikut.
     - Install [Chocolatey](https://chocolatey.org/install) pada komputermu.
     - Setelah berhasil, install [lcov](https://community.chocolatey.org/packages/lcov) dengan menjalankan perintah berikut.
       ```
       choco install lcov
       ```
     - Kemudian cek **Environtment Variabel** pada kolom **System variabels** terdapat variabel GENTHTML dan LCOV_HOME. Jika tidak tersedia, Anda bisa menambahkan variabel baru dengan nilai seperti berikut.
       | Variable | Value|
       | ----------- | ----------- |
       | GENTHTML | C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml |
       | LCOV_HOME | C:\ProgramData\chocolatey\lib\lcov\tools |

2. Untuk mempermudah proses verifikasi testing, jalankan perintah berikut.
   ```
   git init
   ```
3. Kemudian jalankan berkas `test.sh` dengan perintah berikut pada _terminal_ atau _powershell_.
   ```
   test.sh
   ```
   atau
   ```
   ./test.sh
   ```
   Proses ini akan men-_generate_ berkas `lcov.info` dan folder `coverage` terkait dengan laporan coverage.
4. Tunggu proses testing selesai hingga muncul web terkait laporan coverage.

   ```
   genhtml coverage/lcov.info -o coverage/html

   open coverage/html/index.html
   ```

5. Generate Mocks
   ```
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
