import 'package:provider/provider.dart'; 
import '../../../theme/theme_provider.dart'; 
import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 
import 'package:path_provider/path_provider.dart'; 
import 'package:flutter_image_compress/flutter_image_compress.dart'; 
import 'package:shared_preferences/shared_preferences.dart'; 
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../onboarding/login_page.dart';

// O Import já estava aqui, perfeito!
import '../../achievements/presentation/pages/achievements_page.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String _userName = "Estudante";
  String _userEmail = "email@estudante.com";
  String? _imagePath; 

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadLocalImage(); 
  }

  // 1. Carrega dados do Supabase
  Future<void> _loadUserData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final data = await Supabase.instance.client
          .from('usuario')
          .select('nome, email')
          .eq('uid', user.id)
          .maybeSingle();
      
      if (data != null && mounted) {
        setState(() {
          _userName = data['nome'] ?? "Estudante";
          _userEmail = data['email'] ?? user.email!;
        });
      }
    }
  }

  // 2. Carrega a foto salva no celular
  Future<void> _loadLocalImage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString('profile_image_path');
    
    if (savedPath != null && await File(savedPath).exists()) {
      setState(() {
        _imagePath = savedPath;
      });
    }
  }

  // 3. Lógica para Escolher, Comprimir e Salvar a foto
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? originalFile = await picker.pickImage(source: source);

    if (originalFile != null) {
      final dir = await getApplicationDocumentsDirectory();
      final targetPath = '${dir.path}/profile_compressed.jpg';

      if (await File(targetPath).exists()) {
        await File(targetPath).delete();
      }

      var result = await FlutterImageCompress.compressAndGetFile(
        originalFile.path,
        targetPath,
        quality: 70, 
        rotate: 0,   
      );

      if (result != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile_image_path', result.path);

        setState(() {
          _imagePath = result.path;
        });
      }
    }
  }

  void _showPickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeria'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Câmera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return "Fit";
    List<String> names = name.trim().split(" ");
    String initials = names[0][0];
    if (names.length > 1) {
      initials += names.last[0];
    }
    return initials.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasValidImage = _imagePath != null && File(_imagePath!).existsSync();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            accountName: Text(
              _userName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text(_userEmail),
            currentAccountPicture: Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: hasValidImage 
                      ? FileImage(File(_imagePath!)) 
                      : null,
                  child: !hasValidImage
                      ? Text(
                          _getInitials(_userName),
                          style: const TextStyle(fontSize: 24, color: Colors.blue),
                        )
                      : null,
                ),
                
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: _showPickerOptions,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Icon(Icons.camera_alt, size: 20, color: Colors.blue),
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Início'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Meu Perfil'),
            onTap: () {
               // Navegação futura
            },
          ),

          // --- 🏆 ADICIONEI O BOTÃO DE CONQUISTAS AQUI ---
          ListTile(
            leading: const Icon(Icons.emoji_events, color: Colors.amber),
            title: const Text('Conquistas'),
            onTap: () {
              Navigator.pop(context); // Fecha o drawer
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AchievementsPage()));
            },
          ),
          // -----------------------------------------------

          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return SwitchListTile(
                title: const Text('Modo Escuro'),
                secondary: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
                value: themeProvider.isDarkMode,
                onChanged: (bool value) {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sair', style: TextStyle(color: Colors.red)),
            onTap: () async {
               await Supabase.instance.client.auth.signOut();
               
               if (!context.mounted) return;

               Navigator.pushAndRemoveUntil(
                 context, 
                 MaterialPageRoute(builder: (_) => const LoginPage()),
                 (route) => false
               );
            },
          ),
        ],
      ),
    );
  }
}