import 'package:app_comunic/app/data/data/fault.dart';
import 'package:app_comunic/app/data/data/fault_repository.dart';
import 'package:app_comunic/app/ui/pages/dashboard/single_fault.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'widget/chart_indicator_widget.dart';

class FaultDashboard extends StatefulWidget {
  List<Fault> faults = [];
  String dropdownValue = "Pendientes";
  bool loading = true;

  FaultDashboard({Key? key}) : super(key: key);

  @override
  _FaultDashboardState createState() => _FaultDashboardState();
}

class _FaultDashboardState extends State<FaultDashboard> {
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

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      fetchFaultDataList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /* appBar: AppBar(
          title: const Text("Dashboard"),
        ), */
        body: widget.loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Total de averías: ${widget.faults.length}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 200,
                    child: Row(
                      children: [
                        Expanded(
                          child: PieChart(
                            PieChartData(
                                sectionsSpace: 10,
                                centerSpaceRadius: 40,
                                sections: showingSections()),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Expanded(
                              child: SizedBox(
                                height: 1,
                              ),
                            ),
                            Indicator(
                              color: Color(0xFFDD4B31),
                              text: 'Pendientes',
                              isSquare: true,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Indicator(
                              color: Color(0xFF1D9928),
                              text: 'Atendidos',
                              isSquare: true,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  DropdownButton(
                    value: widget.dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.dropdownValue = newValue!;
                      });
                    },
                    items: [
                      "Pendientes",
                      "Atendidos",
                    ]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: showingFaults().length,
                      itemBuilder: (context, index) {
                        var list = showingFaults();
                        var indexes = pendingFaultsIndexes();
                        return Card(
                          child: GestureDetector(
                            onTap: () async {
                              await Navigator.of(context)
                                  .push(
                                    MaterialPageRoute(
                                      builder: (context) => SingleFaultView(
                                        index: indexes[index],
                                      ),
                                    ),
                                  )
                                  .then(
                                    (value) => setState(
                                      () {
                                        fetchFaultDataList();
                                      },
                                    ),
                                  );
                            },
                            child: ListTile(
                              title: Text(list[index].name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(list[index].detail),
                                  Text("Estado: ${list[index].estado}"),
                                ],
                              ),
                              isThreeLine: true,
                              trailing: list[index].estado == "Pendiente"
                                  ? IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Aviso"),
                                              content: const Text(
                                                  "¿Esta seguro de querer actualizar el estado de la avería a 'Atendido'?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, 'Cancel');
                                                  },
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(
                                                        context, 'OK');
                                                    await FaultRepository()
                                                        .updateState(
                                                            indexes[index],
                                                            "Atendido");
                                                    setState(() {
                                                      fetchFaultDataList();
                                                    });
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.check),
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  List<Fault> showingFaults() {
    List<Fault> selected = [];
    String estado =
        (widget.dropdownValue == "Pendientes") ? "Pendiente" : "Atendido";
    for (Fault i in widget.faults) {
      if (i.estado == estado) selected.add(i);
    }
    return selected;
  }

  List<int> pendingFaultsIndexes() {
    List<int> indexes = [];
    String estado =
        (widget.dropdownValue == "Pendientes") ? "Pendiente" : "Atendido";
    int index = 0;
    for (Fault i in widget.faults) {
      if (i.estado == estado) indexes.add(index);
      index++;
    }
    return indexes;
  }

  int onlyPendingFaults() {
    int pending = 0;
    for (int i = 0; i < widget.faults.length; i++) {
      if (widget.faults[i].estado == "Pendiente") pending++;
    }
    return pending;
  }

  List<PieChartSectionData> showingSections() {
    int pending = 0;
    for (int i = 0; i < widget.faults.length; i++) {
      if (widget.faults[i].estado == "Pendiente") pending++;
    }
    if (pending == 0) {
      return List.generate(
        1,
        (index) {
          switch (index) {
            case 0:
              return PieChartSectionData(
                color: const Color(0xFF1D9928),
                value: (widget.faults.length - pending) * 1.0,
                title: (widget.faults.length - pending).toString(),
                radius: 20,
                titleStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffffffff)),
              );
            default:
              throw Error();
          }
        },
      );
    } else if (pending == widget.faults.length) {
      return List.generate(
        1,
        (index) {
          switch (index) {
            case 0:
              return PieChartSectionData(
                color: const Color(0xFFDD4B31),
                value: pending * 1.0,
                title: pending.toString(),
                radius: 20,
                titleStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF)),
              );
            default:
              throw Error();
          }
        },
      );
    } else {
      return List.generate(
        2,
        (index) {
          switch (index) {
            case 0:
              return PieChartSectionData(
                color: const Color(0xFFDD4B31),
                value: pending * 1.0,
                title: pending.toString(),
                radius: 20,
                titleStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF)),
              );
            case 1:
              return PieChartSectionData(
                color: const Color(0xFF1D9928),
                value: (widget.faults.length - pending) * 1.0,
                title: (widget.faults.length - pending).toString(),
                radius: 20,
                titleStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffffffff)),
              );
            default:
              throw Error();
          }
        },
      );
    }
  }
}
