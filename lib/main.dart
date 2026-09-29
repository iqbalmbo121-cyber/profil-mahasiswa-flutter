
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const ProfilMahasiswaApp());
}

class ProfilMahasiswaApp extends StatelessWidget {
  const ProfilMahasiswaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil Mahasiswa',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
        ),
      ),
      home: const ProfilMahasiswaPage(),
    );
  }
}

class ProfilMahasiswaPage extends StatefulWidget {
  const ProfilMahasiswaPage({super.key});

  @override
  State<ProfilMahasiswaPage> createState() =>
      _ProfilMahasiswaPageState();
}

class _ProfilMahasiswaPageState
    extends State<ProfilMahasiswaPage> {
  final TextEditingController namaController =
      TextEditingController();

  final TextEditingController npmController =
      TextEditingController();

  final TextEditingController jurusanController =
      TextEditingController();

  Uint8List? fotoProfil;

  String nama = '';
  String npm = '';
  String jurusan = '';

  bool dataTersimpan = false;

  Future<void> pilihFoto() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      final bytes = await image.readAsBytes();

      setState(() {
        fotoProfil = bytes;
      });
    }
  }

  void simpanData() {
    if (namaController.text.trim().isEmpty ||
        npmController.text.trim().isEmpty ||
        jurusanController.text.trim().isEmpty ||
        fotoProfil == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text('Lengkapi semua data terlebih dahulu'),
            ],
          ),
          backgroundColor: Colors.orange.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    setState(() {
      nama = namaController.text.trim();
      npm = npmController.text.trim();
      jurusan = jurusanController.text.trim();
      dataTersimpan = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text('Data berhasil disimpan'),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    npmController.dispose();
    jurusanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                24,
                45,
                24,
                70,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF4F46E5),
                    Color(0xFF6366F1),
                    Color(0xFF818CF8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 700,
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.school_rounded,
                        color: Colors.white,
                        size: 42,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'PROFIL MAHASISWA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Lengkapi data profil mahasiswa Anda',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ================= FORM =================
            Transform.translate(
              offset: const Offset(0, -40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 650,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black..withValues(alpha: 0.08),
                                blurRadius: 25,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Data Mahasiswa',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF111827),
                                ),
                              ),

                              const SizedBox(height: 6),

                              const Text(
                                'Masukkan informasi Anda di bawah ini',
                                style: TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontSize: 14,
                                ),
                              ),

                              const SizedBox(height: 28),

                              // FOTO
                              Center(
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: pilihFoto,
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 130,
                                            height: 130,
                                            decoration:
                                                BoxDecoration(
                                              shape:
                                                  BoxShape.circle,
                                              border: Border.all(
                                                color:
                                                    const Color(
                                                  0xFF6366F1,
                                                ),
                                                width: 4,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors
                                                      .indigo
                                                      ..withValues(alpha: 0.08),
                                                  blurRadius: 15,
                                                ),
                                              ],
                                            ),
                                            child: CircleAvatar(
                                              radius: 63,
                                              backgroundColor:
                                                  const Color(
                                                0xFFEEF2FF,
                                              ),
                                              backgroundImage:
                                                  fotoProfil !=
                                                          null
                                                      ? MemoryImage(
                                                          fotoProfil!,
                                                        )
                                                      : null,
                                              child: fotoProfil ==
                                                      null
                                                  ? const Icon(
                                                      Icons
                                                          .person_rounded,
                                                      size: 60,
                                                      color: Color(
                                                        0xFF6366F1,
                                                      ),
                                                    )
                                                  : null,
                                            ),
                                          ),

                                          Positioned(
                                            right: 2,
                                            bottom: 4,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets
                                                      .all(10),
                                              decoration:
                                                  const BoxDecoration(
                                                color: Color(
                                                  0xFF4F46E5,
                                                ),
                                                shape:
                                                    BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons
                                                    .camera_alt_rounded,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 12),

                                    const Text(
                                      'Pilih Foto Profil',
                                      style: TextStyle(
                                        color: Color(0xFF4F46E5),
                                        fontWeight:
                                            FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 30),

                              // NAMA
                              _buildLabel('Nama Lengkap'),
                              const SizedBox(height: 8),
                              _buildTextField(
                                controller: namaController,
                                hint: 'Masukkan nama lengkap',
                                icon: Icons.person_outline_rounded,
                              ),

                              const SizedBox(height: 20),

                              // NPM
                              _buildLabel('NPM'),
                              const SizedBox(height: 8),
                              _buildTextField(
                                controller: npmController,
                                hint: 'Masukkan NPM',
                                icon: Icons.badge_outlined,
                              ),

                              const SizedBox(height: 20),

                              // JURUSAN
                              _buildLabel('Jurusan'),
                              const SizedBox(height: 8),
                              _buildTextField(
                                controller:
                                    jurusanController,
                                hint: 'Masukkan jurusan',
                                icon:
                                    Icons.account_balance_outlined,
                              ),

                              const SizedBox(height: 30),

                              // SAVE BUTTON
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: simpanData,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(0xFF4F46E5),
                                    foregroundColor:
                                        Colors.white,
                                    elevation: 0,
                                    shape:
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(
                                        14,
                                      ),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons
                                            .save_rounded,
                                        size: 21,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Simpan Data',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                              FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ================= HASIL =================
                        if (dataTersimpan) ...[
                          const SizedBox(height: 25),

                          Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.all(28),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      ..withValues(alpha: 0.06),
                                  blurRadius: 20,
                                  offset:
                                      const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.all(12),
                                  decoration:
                                      BoxDecoration(
                                    color: Colors.green
                                        ..withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons
                                        .check_circle_rounded,
                                    color: Colors.green,
                                    size: 32,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                const Text(
                                  'Data Berhasil Disimpan',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight:
                                        FontWeight.w800,
                                    color:
                                        Color(0xFF111827),
                                  ),
                                ),

                                const SizedBox(height: 25),

                                CircleAvatar(
                                  radius: 58,
                                  backgroundColor:
                                      const Color(0xFFEEF2FF),
                                  backgroundImage:
                                      MemoryImage(
                                    fotoProfil!,
                                  ),
                                ),

                                const SizedBox(height: 25),

                                _buildInfoRow(
                                  Icons.person_rounded,
                                  'Nama',
                                  nama,
                                ),

                                _buildInfoRow(
                                  Icons.badge_rounded,
                                  'NPM',
                                  npm,
                                ),

                                _buildInfoRow(
                                  Icons.school_rounded,
                                  'Jurusan',
                                  jurusan,
                                ),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: 30),

                        const Text(
                          '© 2026 Profil Mahasiswa',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        color: Color(0xFF374151),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF6366F1),
        ),
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 17,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFE5E7EB),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFE5E7EB),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFF6366F1),
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF4F46E5),
              size: 21,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

