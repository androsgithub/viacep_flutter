import 'package:flutter/material.dart';
import 'package:viacep_flutter/model/back4app_cep_model.dart';
import 'package:viacep_flutter/model/viacep_model.dart';
import 'package:viacep_flutter/pages/registered_ceps_page.dart';
import 'package:viacep_flutter/repositories/back4app_cep_repository.dart';
import 'package:viacep_flutter/repositories/viacep_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  bool exists = false;

  Back4appCepRepository back4appCepRepository = Back4appCepRepository();

  ViacepRepository viacepRepository = ViacepRepository();
  ViacepModel? viacepModel;

  TextEditingController cepController = TextEditingController(text: "");

  buscarCep() async {
    setState(() {
      loading = true;
    });

    try {
      String cep = cepController.text.replaceAll(RegExp(r'[^0-9]'), '');
      if (cep.length >= 8) {
        viacepModel = await viacepRepository.getCep(cep);

        exists = await back4appCepRepository.exists(cep);
        if (!exists) {
          await back4appCepRepository.addCep(Cep.simple(cep));
        }
      }
    } catch (e) {
      //dei erro
    }
    setState(() {
      loading = false;
    });
  }

  exibirLista() async {
    Navigator.push(context,
        MaterialPageRoute(builder: (bc) => const RegisteredCepsPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("V I A  C E P - F L U T T E R"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: exibirLista,
        child: const Icon(Icons.list),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "FAÇA SUA BUSCA",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: cepController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: buscarCep,
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  child: const Text(
                    "Buscar",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Visibility(
                visible: loading,
                child: const Column(
                  children: [
                    SizedBox(height: 10),
                    CircularProgressIndicator(),
                  ],
                )),
            Visibility(
                visible: viacepModel != null && !loading,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      exists ? "Este cep ja esta registrado" : "Cep registrado",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Cep encontrado",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Estado: ${viacepModel?.uf}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Cidade: ${viacepModel?.localidade!}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Bairro: ${viacepModel?.bairro!}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "Logradouro: ${viacepModel?.logradouro!}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
