import 'package:app/app/servicos/autorizacao.dart';
import 'package:app/custom_widget/submit_button.dart';
import 'package:app/custom_widget/platform_exception_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'notifier_model.dart';

class EmailESenhaFormNotifier extends StatefulWidget {
  EmailESenhaFormNotifier({@required this.model});
  final EmailESennhaNotifierModel model;

  static Widget create(BuildContext context) {
    final AutorizacaoBase autorizacao = Provider.of<AutorizacaoBase>(context);
    return ChangeNotifierProvider<EmailESennhaNotifierModel>(
      create: (context) => EmailESennhaNotifierModel(autorizacao: autorizacao),
      child: Consumer<EmailESennhaNotifierModel>(
        builder: (context, model, _) => EmailESenhaFormNotifier(model: model),
      ),
    );
  }

  @override
  _EmailESenhaFormNotifierState createState() =>
      _EmailESenhaFormNotifierState();
}

class _EmailESenhaFormNotifierState extends State<EmailESenhaFormNotifier> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final FocusNode _emailFocado = FocusNode();
  final FocusNode _senhaFocada = FocusNode();

  EmailESennhaNotifierModel get model => widget.model;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    _emailFocado.dispose();
    _senhaFocada.dispose();
    super.dispose();
  }

  Future<void> _entrar() async {
    try {
      await model.entrar();
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Ops! Algo deu errado... :(',
        exception: e,
      ).show(context);
    }
  }

  void _emailPreenchido() {
    final foco =
        model.validaEmail.ehValido(model.email) ? _senhaFocada : _emailFocado;
    FocusScope.of(context).requestFocus(foco);
  }

  void _alterarTipoDoFormulario() {
    model.alteraTipoDoFormulario();
    _emailController.clear();
    _senhaController.clear();
  }

  List<Widget> _buildChildren() {
    return [
      _buildCampoEmail(),
      SizedBox(
        height: 20.0,
      ),
      _buildCampoSenha(),
      SizedBox(
        height: 20.0,
      ),
      CustomSubmitButtom(
        text: model.paraEntrar,
        onPressed: model.enviarDados ? _entrar : null,
      ),
      SizedBox(
        height: 10.0,
      ),
      FlatButton(
        child: Text(model.paraRegistrar),
        onPressed: !model.carregando ? _alterarTipoDoFormulario : null,
      ),
    ];
  }

  TextField _buildCampoEmail() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocado,
      decoration: InputDecoration(
        labelText: 'E-mail',
        hintText: 'email@dominio.com',
        errorText: model.trataCampoEmail,
        enabled: model.carregando == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: model.autalizaEmail,
      onEditingComplete: () => _emailPreenchido(),
    );
  }

  TextField _buildCampoSenha() {
    return TextField(
      controller: _senhaController,
      focusNode: _senhaFocada,
      decoration: InputDecoration(
        labelText: 'Senha',
        errorText: model.trataCampoSenha,
        enabled: model.carregando == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: model.autalizaSenha,
      onEditingComplete: _entrar,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
