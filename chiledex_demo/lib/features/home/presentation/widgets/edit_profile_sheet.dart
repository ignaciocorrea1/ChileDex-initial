import 'package:chiledex_demo/app/theme/app_theme.dart';
import 'package:chiledex_demo/core/data/services/chiledex_api.dart';
import 'package:chiledex_demo/core/domain/models/usuario_model.dart';
import 'package:flutter/material.dart';

class EditProfileSheet extends StatefulWidget {
  final UsuarioModel usuario;
  final ChiledexApi api;

  const EditProfileSheet({
    super.key,
    required this.usuario,
    required this.api,
  });

  @override
  State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _paternalController;
  late final TextEditingController _maternalController;
  late final TextEditingController _emailController;
  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.usuario.nombre);
    _paternalController = TextEditingController(
      text: widget.usuario.apellidoPaterno ?? '',
    );
    _maternalController = TextEditingController(
      text: widget.usuario.apellidoMaterno ?? '',
    );
    _emailController = TextEditingController(text: widget.usuario.correo);
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _paternalController.dispose();
    _maternalController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });

    try {
      final user = await widget.api.actualizarUsuario(
        usuarioId: widget.usuario.id,
        email: _emailController.text.trim(),
        nombre: _nameController.text.trim(),
        apPaterno: _optional(_paternalController.text),
        apMaterno: _optional(_maternalController.text),
        fotoPerfilUrl: widget.usuario.fotoPerfilUrl,
      );
      final currentPassword = _currentPasswordController.text;
      final newPassword = _newPasswordController.text;
      final confirmation = _confirmPasswordController.text;
      if (currentPassword.isNotEmpty || newPassword.isNotEmpty || confirmation.isNotEmpty) {
        await widget.api.cambiarContrasena(
          usuarioId: widget.usuario.id,
          currentPassword: currentPassword,
          newPassword: newPassword,
        );
      }
      if (mounted) Navigator.pop(context, user);
    } catch (error) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error = error.toString().replaceFirst('Exception: ', '');
        });
      }
    }
  }

  String? _optional(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundCream,
      appBar: AppBar(
        title: const Text('Editar perfil'),
        leading: IconButton(
          tooltip: 'Volver',
          onPressed: _saving ? null : () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) => value == null || value.trim().length < 2
                      ? 'Ingresa un nombre válido'
                      : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _paternalController,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: 'Apellido paterno',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _maternalController,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: 'Apellido materno',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: Icon(Icons.mail_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa tu correo';
                    }
                    if (!value.contains('@')) return 'Correo no válido';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _currentPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña actual',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? (_newPasswordController.text.isNotEmpty ||
                          _confirmPasswordController.text.isNotEmpty
                        ? 'Ingresa tu contraseña actual'
                        : null)
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Nueva contraseña',
                    helperText: 'Mínimo 8 caracteres',
                    prefixIcon: Icon(Icons.lock_reset_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return _currentPasswordController.text.isNotEmpty ||
                              _confirmPasswordController.text.isNotEmpty
                          ? 'Ingresa una nueva contraseña'
                          : null;
                    }
                    return value.length < 8 ? 'Usa al menos 8 caracteres' : null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Repite la nueva contraseña',
                    prefixIcon: Icon(Icons.verified_user_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return _currentPasswordController.text.isNotEmpty ||
                              _newPasswordController.text.isNotEmpty
                          ? 'Confirma la nueva contraseña'
                          : null;
                    }
                    return value != _newPasswordController.text
                        ? 'Las contraseñas no coinciden'
                        : null;
                  },
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    style: const TextStyle(color: AppTheme.accentOrange),
                  ),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saving ? null : _save,
                  child: _saving
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Guardar cambios'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
