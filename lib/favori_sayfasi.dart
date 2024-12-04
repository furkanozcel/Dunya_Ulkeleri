import 'package:dunya_ulkeleri/ulke.dart';
import 'package:dunya_ulkeleri/ulke_detay_sayfasi.dart';
import 'package:flutter/material.dart';

class FavoriSayfasi extends StatefulWidget {
  final List<Ulke> _butunUlkeler;
  final List<String> _favoriUlkeKodlari;

  const FavoriSayfasi(this._butunUlkeler, this._favoriUlkeKodlari, {super.key});

  @override
  State<FavoriSayfasi> createState() => _FavoriSayfasiState();
}

class _FavoriSayfasiState extends State<FavoriSayfasi> {
  final List<Ulke> _favoriUlkeler = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (Ulke ulke in widget._butunUlkeler) {
      if (widget._favoriUlkeKodlari.contains(ulke.ulkeKodu)) {
        _favoriUlkeler.add(ulke);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Favoriler"),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: _favoriUlkeler.length,
      itemBuilder: (BuildContext context, int index) {
        Ulke ulke = widget._butunUlkeler[index];
        return Card(
          child: ListTile(
            onTap: () {
              ulkeTiklandi(context, ulke);
            },
            title: Text(ulke.isim),
          ),
        );
      },
    );
  }

  void ulkeTiklandi(BuildContext context, Ulke ulke) {
    MaterialPageRoute sayfaYolu = MaterialPageRoute(
      builder: (context) {
        return UlkeDetaySayfasi(ulke);
      },
    );
    Navigator.push(context, sayfaYolu);
  }
}
