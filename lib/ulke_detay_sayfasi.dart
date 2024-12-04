import 'package:dunya_ulkeleri/ulke.dart';
import 'package:flutter/material.dart';

class UlkeDetaySayfasi extends StatelessWidget {
  const UlkeDetaySayfasi(this._ulke, {super.key});

  final Ulke _ulke;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blue,
      title: Text(_ulke.isim),
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
          height: 32,
        ),
        _buildBayrak(context),
        const SizedBox(
          height: 24,
        ),
        _buildUlkeIsmi(),
        const SizedBox(
          height: 36,
        ),
        _buildUlkeIsmiRow(),
        _buildUlkeBaskenIsmiRow(),
        _buildUlkeBolgeIsmiRow(),
        _buildUlkeNufusRow(),
        _buildUlkeninDilRow(),
      ],
    );
  }

  Widget _buildBayrak(BuildContext context) {
    return Image.network(
      _ulke.bayrak,
      width: MediaQuery.of(context).size.width / 2,
    );
  }

  Widget _buildUlkeIsmi() {
    return Text(
      _ulke.isim,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildUlkeIsmiRow() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "Ülke ismi : ",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            _ulke.isim,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }

  Widget _buildUlkeBaskenIsmiRow() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "Başkent : ",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            _ulke.baskent,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }

  Widget _buildUlkeBolgeIsmiRow() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "Bölge : ",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            _ulke.bolge,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }

  Widget _buildUlkeNufusRow() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "Nüfus : ",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            _ulke.nufus.toString(),
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }

  Widget _buildUlkeninDilRow() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            "Dil : ",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            _ulke.dil,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ],
    );
  }
}
