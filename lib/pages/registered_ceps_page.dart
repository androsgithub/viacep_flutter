import 'package:flutter/material.dart';
import 'package:viacep_flutter/model/back4app_cep_model.dart';
import 'package:viacep_flutter/repositories/back4app_cep_repository.dart';

class RegisteredCepsPage extends StatefulWidget {
  const RegisteredCepsPage({super.key});

  @override
  State<RegisteredCepsPage> createState() => _RegisteredCepsPageState();
}

class _RegisteredCepsPageState extends State<RegisteredCepsPage> {
  bool loading = false;

  Back4appCepModel back4appCepModel = Back4appCepModel();
  Back4appCepRepository back4appCepRepository = Back4appCepRepository();

  carregarCeps() async {
    setState(() {
      loading = true;
    });
    back4appCepModel = await back4appCepRepository.getAllCeps();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    carregarCeps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("C E P S - R E G I S T R A D O S"),
        centerTitle: true,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: back4appCepModel.ceps.length,
              itemBuilder: (_, index) {
                Cep cep = back4appCepModel.ceps[index];
                return _cepButton(cep);
              }),
    );
  }

  Widget _cepButton(Cep cep) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            cep.cep!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          IconButton(
            onPressed: () async {
              await back4appCepRepository.removeCep(cep);
              carregarCeps();
            },
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red)),
            icon: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
        ],
      ));
}
