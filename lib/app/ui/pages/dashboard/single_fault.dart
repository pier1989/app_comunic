import 'package:app_comunic/app/data/data/fault.dart';
import 'package:app_comunic/app/data/data/fault_repository.dart';
import 'package:flutter/material.dart';

class SingleFaultView extends StatefulWidget {
  SingleFaultView({Key? key, required this.index}) : super(key: key);
  List<Fault> faults = [];
  final int index;
  bool loading = true;
  @override
  _SingleFaultViewState createState() => _SingleFaultViewState();
}

class _SingleFaultViewState extends State<SingleFaultView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future fetchFaultDataList() async {
    widget.loading = true;
    var result = await FaultRepository().getFaults();
    widget.faults.clear();
    widget.loading = false;
    setState(() {
      for (Fault i in result) {
        widget.faults.add(i);
      }
    });
  }

  void setControllers() {
    nameController.text = widget.faults[widget.index].name;
    descriptionController.text = widget.faults[widget.index].detail;
  }

  @override
  initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      fetchFaultDataList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widget.loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 400,
                          child: Image.network(
                            widget.faults[widget.index].img,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Título: ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.faults[widget.index].name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Descripción: ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.faults[widget.index].detail,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            const Text(
                              "Fecha: ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.faults[widget.index].date,
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            const Text(
                              "Hora: ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.faults[widget.index].time,
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        child: Row(
                          children: [
                            const Text(
                              "Estado: ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.faults[widget.index].estado,
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                setControllers();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                      height: 200,
                                      child: AlertDialog(
                                        title: const Text("Editar información"),
                                        content: SizedBox(
                                          height: 140,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  icon: Icon(Icons.title),
                                                  hintText: 'Nombre de falla',
                                                  labelText: 'Titulo *',
                                                ),
                                                controller: nameController,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  icon: Icon(Icons
                                                      .description_outlined),
                                                  hintText:
                                                      'Detalles de la falla',
                                                  labelText: 'Detalles *',
                                                ),
                                                controller:
                                                    descriptionController,
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.pop(context, 'Guardar');
                                              Fault ans = Fault(
                                                date: widget
                                                    .faults[widget.index].date,
                                                detail:
                                                    descriptionController.text,
                                                estado: widget
                                                    .faults[widget.index]
                                                    .estado,
                                                img: widget
                                                    .faults[widget.index].img,
                                                name: nameController.text,
                                                time: widget
                                                    .faults[widget.index].time,
                                              );
                                              await FaultRepository()
                                                  .updateFault(
                                                      widget.index, ans);
                                              setState(() {
                                                fetchFaultDataList();
                                              });
                                            },
                                            child: const Text('Guardar'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text("Editar"))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
