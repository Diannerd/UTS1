#PENJELASAN PROYEK
perbedaan Cubit dan BLoC dalam Arsitektur Flutter:
Meskipun Cubit merupakan bagian dari Bloc Library, keduanya menawarkan pendekatan yang berbeda dalam mengelola state (keadaan) aplikasi:
Cubit hanya menggunakan fungsi emit(newState) untuk memancarkan state baru secara langsung. Ini membuatnya lebih lugas dan sederhana.
BLoC menggunakan Events (Input) untuk memicu perubahan. Events ini kemudian diproses melalui handler Event untuk menghasilkan State baru (Output).

#Kompleksitas
Cubit memiliki boilerplate (kode tambahan) yang sangat minimal. Cocok untuk logika yang hanya perlu memancarkan state baru berdasarkan pemanggilan fungsi sederhana.
BLoC lebih kompleks dan formal. Cocok untuk logika bisnis yang rumit dan membutuhkan middleware seperti debounce, throttle, atau validasi yang ketat sebelum memproses state.

#Penggunaan Stream
Cubit: Menggunakan Stream secara internal untuk mengelola urutan state, tetapi penggunaan ini sepenuhnya disembunyikan dan diekspos melalui fungsi emit yang mudah diakses.
BLoC: Menggunakan dua Stream utama secara eksplisit, yaitu Event Stream (sebagai input dari UI) dan State Stream (sebagai output ke UI), menekankan pada pola Reactive Programming.

#Fokus Arsitektur

#Jawaban Teori
Mengapa Penting Memisahkan Model Data, Logika Bisnis, dan UI?
Pemisahan ini penting dalam pengembangan aplikasi modern karena prinsip Separation of Concerns (Pemisahan Kekhawatiran) yang memberikan beberapa keuntungan utama:

Maintainability (Kemudahan Perawatan): Memperbaiki bug atau memperbarui logika bisnis (di Cubit) tidak akan secara langsung merusak atau memerlukan perubahan pada tampilan (di UI), dan sebaliknya.

Testability (Kemudahan Pengujian): Logika bisnis (Cubit) dapat diuji secara independen (unit test) tanpa perlu me-render komponen UI.

Reusability (Dapat Digunakan Kembali): Model data (ProductModel) dan logika bisnis (CartCubit) dapat digunakan kembali di berbagai tampilan (UI) yang berbeda.

Tiga State Minimum yang Mungkin Digunakan dalam CartCubit
Meskipun CartCubit ini menggunakan satu tipe CartState (Map<ProductModel, int>), ada tiga kondisi logis (State) yang direpresentasikan dan penting dalam UI:

State Kosong (Empty State):

Representasi: Peta kosong ({}).

Fungsi: Ditampilkan di UI sebagai pesan "Keranjang Anda kosong."

State Berisi (Loaded/Data State):

Representasi: Peta berisi data produk dan kuantitasnya ({ProductA: 1, ProductB: 3}).

Fungsi: Digunakan untuk membangun daftar item di CartSummaryPage dan menghitung total harga/item.

State Transisi (Update State):

Representasi: Peta dengan nilai yang berubah (misalnya, dari qty: 1 menjadi qty: 2).

Fungsi: Memicu rebuild pada BlocBuilder di AppBar dan CartSummaryPage, sehingga total item dan harga diperbarui secara real-time.
