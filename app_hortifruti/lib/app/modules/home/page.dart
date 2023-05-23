import 'package:app_hortifruti/app/modules/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Hortifruti'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                leading: FlutterLogo(),
                title: Text('Horti verde'),
                trailing: Text('Aberto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
