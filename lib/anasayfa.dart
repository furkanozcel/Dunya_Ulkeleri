import 'dart:convert';

import 'package:dunya_ulkeleri/favori_sayfasi.dart';
import 'package:dunya_ulkeleri/ulke_detay_sayfasi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'ulke.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  final String _apiUrl =
      "https://restcountries.com/v3.1/all?fields=name,flags,cca2,capital,region,languages,population";

  final List<Ulke> _butunUlkeler = [];

  final List<String> _favoriUlkeKodlari = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _favorileriCihazHafizasindanCek().then((value) {
        internettenVeriCek();
      });
    });
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
      title: const Text("Tüm Ülkeler"),
      centerTitle: true,
      backgroundColor: Colors.blue,
      actions: [
        IconButton(
          onPressed: () {
            _favoriSayfasinaGecis();
          },
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 27,
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return _butunUlkeler.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: _butunUlkeler.length, itemBuilder: _buildListItem);
  }

  void internettenVeriCek() async {
    Uri uri = Uri.parse(_apiUrl);
    http.Response response = await http.get(uri);

    List<dynamic> parsedResponse = jsonDecode(response.body);

    for (var i = 0; i < parsedResponse.length; i++) {
      Map<String, dynamic> ulkeMap = parsedResponse[i];
      Ulke ulke = Ulke.fromMap(ulkeMap);
      _butunUlkeler.add(ulke);
    }

    setState(() {});
  }

  Widget? _buildListItem(BuildContext context, int index) {
    Ulke ulke = _butunUlkeler[index];
    return Card(
      child: ListTile(
        onTap: () {
          ulkeTiklandi(context, ulke);
        },
        title: Text(ulke.isim),
        subtitle: Text("Başkent : ${ulke.baskent}"),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(ulke.bayrak),
        ),
        trailing: IconButton(
          onPressed: () {
            _favoriTiklandi(ulke);
          },
          icon: Icon(
            _favoriUlkeKodlari.contains(ulke.ulkeKodu)
                ? Icons.favorite
                : Icons.favorite_border,
            color: Colors.red,
          ),
        ),
      ),
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

  void _favoriTiklandi(Ulke ulke) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_favoriUlkeKodlari.contains(ulke.ulkeKodu)) {
      _favoriUlkeKodlari.remove(ulke.ulkeKodu);
    } else {
      _favoriUlkeKodlari.add(ulke.ulkeKodu);
    }

    await prefs.setStringList("favoriler", _favoriUlkeKodlari);

    setState(() {});
  }

  Future _favorileriCihazHafizasindanCek() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriler = prefs.getStringList("favoriler");

    if (favoriler != null) {
      for (String ulkeKodu in favoriler) {
        _favoriUlkeKodlari.add(ulkeKodu);
      }
      setState(() {});
    }
  }

  void _favoriSayfasinaGecis() {
    MaterialPageRoute sayfaYolu = MaterialPageRoute(
      builder: (context) {
        return FavoriSayfasi(_butunUlkeler, _favoriUlkeKodlari);
      },
    );
    Navigator.push(context, sayfaYolu);
  }
}
