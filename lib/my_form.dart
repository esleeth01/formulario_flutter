import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  void _limpiarCampos() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
  }

  void _guardarFormulario() {
    if (_formKey.currentState?.validate() ?? false) {
      String nombre = _nameController.text;
      String correo = _emailController.text;

      bool esCorreoValido =
          RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(correo);

      if (esCorreoValido) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Información del Usuario'),
              content:
                  Text('Usuario de nombre: $nombre, su correo es: $correo'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cerrar'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Por favor, ingresa un correo electrónico válido. No se aceptan caracteres especiales distintos al @.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cerrar'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Formulario'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, ingresa tu nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration:
                    const InputDecoration(labelText: 'Correo Electrónico'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Por favor, ingresa tu correo electrónico';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: _limpiarCampos,
                      child: const Text('Limpiar'),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _guardarFormulario,
                      child: const Text('Guardar'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
