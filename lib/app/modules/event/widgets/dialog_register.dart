import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/controllers/event_controller.dart';

class JoinNowDialog extends StatelessWidget {
  final Function onPressed;

  JoinNowDialog({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    EventController evC = Get.find<EventController>();
    List<TextEditingController> cariAnggotaControllers = List.generate(
      evC.DetailLomba['max_anggota'],
      (index) => TextEditingController(),
    );

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: evC.namaGroup,
                decoration: InputDecoration(
                  label: Text("Nama Group"),
                  border: OutlineInputBorder(),
                ),
              ),
              Column(
                children: List.generate(
                  evC.DetailLomba['max_anggota'],
                  (index) => Column(
                    children: [
                      TextField(
                        controller: cariAnggotaControllers[index],
                        onChanged: (value) async {
                          // Use await to get the result of GetUsers
                          var result = await evC.GetUsers(value);
                          result.removeWhere(
                            (element) => element['name'] == evC.cariKetua.text,
                          );
                          // Use assign instead of setValue
                          evC.PesertaCombox[index].assign(result);
                          if (cariAnggotaControllers[index].text == "") {
                            evC.PesertaCombox[index].clear();
                          }
                        },
                        decoration: InputDecoration(
                          label: Text("Cari Anggota ${index + 1}"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      if (evC.PesertaCombox.length > index)
                        Obx(
                          () => Visibility(
                            visible: evC.PesertaCombox[index].isNotEmpty,
                            child: Container(
                              height: 110,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: ListView(
                                children: List.generate(
                                  evC.PesertaCombox[index].length,
                                  (subIndex) {
                                    return ListTile(
                                      onTap: () {
                                        evC.cariAnggota.text =
                                            "${evC.PesertaCombox[index][subIndex]['name']}";
                                        evC.PesertaCombox[index].clear();
                                      },
                                      title: Text(
                                        evC.PesertaCombox[index].isNotEmpty
                                            ? "${evC.PesertaCombox[index][subIndex]['name']}"
                                            : "",
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text("Join Now"),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text("Close"),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
