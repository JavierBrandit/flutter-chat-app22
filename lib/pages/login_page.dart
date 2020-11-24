import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_services.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/widgets/btn_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels_widget.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea( 
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(titulo: 'Messenger'),
                Form(),
                Labels(titulo: '¿Aun no tines una cuenta?', subtitulo: 'Registrate Ahora', ruta: 'register' ),
                Text('Terminos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w600),)
              ],
            ),
          ),
      ),
      ),
    );
  }
}

class Form extends StatefulWidget {
  @override
  FormState createState() => FormState();
}

class FormState extends State<Form> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
       child: Column( children: <Widget>[
        
        CustomInput(
          icon: Icons.mail_outline,
          placeholder: 'Correo',
          keyboardType: TextInputType.emailAddress,
          textController: emailCtrl,
        ),
        CustomInput(
          icon: Icons.lock_outline,
          placeholder: 'Contraseña',
          isPassword: true,
          textController: passCtrl,
        ),


         BtnAzul(
           txt:'Ingrese', 
           callBack: authService.autenticando ? null : () async {
              
              FocusScope.of(context).unfocus(); 
              
              final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim()); //trim() para que no se pasen espacios o tabs
              
              if ( loginOk ) {
                socketService.connect();
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales nuevamente');
              }
           }
         ),
       ],),
    );
  }
}




