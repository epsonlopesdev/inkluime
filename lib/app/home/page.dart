import 'package:app/app/servicos/autorizacao.dart';
import 'package:app/custom_widget/platform_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  Future<void> _encerraSessao(BuildContext context) async {
    try {
      final autenticacao = Provider.of<AutorizacaoBase>(context);
      await autenticacao.encerraSessao();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmaEncerraSessao(BuildContext context) async {
    final encerramentoDaSessao = await PlatformAlertDialog(
      title: 'Sair',
      content: 'Deseja realmente sair?',
      cancelActionText: 'Não',
      defaultActionText: 'Sim',
    ).show(context);
    if (encerramentoDaSessao == true) {
      _encerraSessao(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        title: Image.asset(
          'lib/assets/imagem/akolhe-logo.png',
          height: 40.0,
        ),


        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle, size: 35,),
            tooltip: 'Área do Cliente',
            onPressed: () {
              _drawerKey.currentState.openEndDrawer();
            },
          ),
        ],


      ),
      endDrawer: _menuLateral(context),
      body: _conteudo(context),
    );
  }

  Widget _conteudo(BuildContext context) {
    return Container(
      child: Text(''),
    );
  }

  Widget _menuLateral(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://scontent-gru2-1.xx.fbcdn.net/v/t31.0-8/p960x960/25299792_1742080809188062_4581160011719734085_o.jpg?_nc_cat=109&_nc_sid=09cbfe&_nc_eui2=AeERUaBptDvDAphmu99Zi9T_m41vAbg4zdebjW8BuDjN19ZPyuRM1SZGaf8Ko8cA7DVAeRsDXFqDtMgC-OqqMgyn&_nc_ohc=GxUJ1ZbU06cAX8MoU1E&_nc_ht=scontent-gru2-1.xx&_nc_tp=6&oh=322d19dc4719dd1028b8bb7c011f8d2e&oe=5ECFD6FC'),
            ),
            /*otherAccountsPictures: [
              CircleAvatar(
                backgroundImage: NetworkImage('https://scontent-gru2-1.xx.fbcdn.net/v/t31.0-8/p960x960/16904705_1444859902243489_3739793644136771899_o.jpg?_nc_cat=111&_nc_sid=174925&_nc_eui2=AeE4G3VFRKvOe76JVO_YeBYfc1c04fzjrARzVzTh_OOsBEdUmKe9yuJSsGZiDkYI2IhwntIEGQ9Sf-P9oz7IGQ71&_nc_ohc=x5CaG5kmXR0AX_rqvtg&_nc_ht=scontent-gru2-1.xx&_nc_tp=6&oh=50a3e186ccee05c2e359fb9de7f0eda8&oe=5ECF5A11'),
              )
            ],*/
            accountName: Text('Epson Lopes'),
            accountEmail: Text('epson@outlook.com'),
          ),
          Padding(
              padding: EdgeInsets.all(5.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.purple,
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.chrome_reader_mode,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    title: Text(
                      'Meus dados',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.black,
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.collections_bookmark,
                      size: 40.0,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Minhas notícias',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.pink,
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.message,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    title: Text(
                      'Minhas indicações',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.orange,
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.folder,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    title: Text(
                      'Meus processos',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.green,
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.local_offer,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    title: Text(
                      'Meus anuncios',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.blueGrey,
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    title: Text(
                      'Configurações',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                onTap: () => _confirmaEncerraSessao(context),
                leading: Icon(
                  Icons.subdirectory_arrow_left,
                  color: Colors.red,
                  size: 40.0,
                ),
                title: Text(
                  'Sair',
                  style: TextStyle(fontSize: 18.0, color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
