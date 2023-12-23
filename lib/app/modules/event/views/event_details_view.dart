import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/controllers/event_controller.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final evC = Get.put(EventController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _showDetailLomba(BuildContext context) {
      showModalBottomSheet(
        context: context,
        
        builder: (BuildContext context) {
          return ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 3,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "${evC.DetailLomba['nama_lomba']}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 220,
                        width: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(evC.DetailLomba['poster'] !=
                                      null
                                  ? "https://tvent.azurewebsites.net/storage/lomba/poster/${evC.DetailLomba['id']}/${evC.DetailLomba['poster']}"
                                  : "https://cdn.ebaumsworld.com/mediaFiles/picture/1151541/84693449.png"),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Room : ${evC.DetailLomba['ruangan_lomba']}"),
                          Text("Group : ${evC.DetailLomba['max_anggota']}"),
                          Text(
                              "Kuota : ${evC.DetailLomba['anggota_terdaftar']} / ${evC.DetailLomba['kuota_lomba']}"),
                          Text(
                              "Start At :${evC.DetailLomba['pelaksanaan_lomba'].toString().substring(0, 10)}"),
                          Text(
                              "${evC.DetailLomba['pelaksanaan_lomba'].toString().substring(11, 19)}"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text("${evC.DetailLomba['keterangan']}"),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Registration"),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: evC.namaGroup,
                    decoration: InputDecoration(
                      label: Text("Nama Group"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: evC.cariKetua,
                    onChanged: (value) {
                      evC.GetUsers(value).then(
                        (value) => {
                          evC.ketuaCombox.value = value,
                        },
                      );
                    },
                    decoration: InputDecoration(
                      label: Text("Cari Anggota/Ketua"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: evC.ketuaCombox.isNotEmpty,
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        )),
                        child: Obx(
                          () => ListView(
                            children: List.generate(
                              evC.ketuaCombox.length,
                              (index) {
                                return Obx(
                                  () => ListTile(
                                    onTap: () {
                                      setState(() {
                                        evC.cariKetua.text =
                                            "${evC.ketuaCombox[index]['name']}";
                                        evC.ketuaCombox.clear();
                                      });
                                    },
                                    title: Text(
                                      evC.ketuaCombox.isNotEmpty
                                          ? "${evC.ketuaCombox[index]['name']}"
                                          : "",
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: evC.cariAnggota,
                    onChanged: (value) {
                      evC.GetUsers(value).then((value) {
                        value.removeWhere(
                            (element) => element['name'] == evC.cariKetua.text);
                        evC.PesertaCombox.value = value;
                      });
                      if (evC.cariAnggota.text == "") {
                        evC.PesertaCombox.clear();
                      }
                    },
                    decoration: InputDecoration(
                      label: Text("Cari Anggota"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: evC.PesertaCombox.isNotEmpty,
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        )),
                        child: Obx(
                          () => ListView(
                            children: List.generate(
                              evC.PesertaCombox.length,
                              (index) {
                                return Obx(
                                  () => ListTile(
                                    onTap: () {
                                      setState(() {
                                        evC.cariAnggota.text =
                                            "${evC.PesertaCombox[index]['name']}";
                                        evC.PesertaCombox.clear();
                                      });
                                    },
                                    title: Text(
                                      evC.PesertaCombox.isNotEmpty
                                          ? "${evC.PesertaCombox[index]['name']}"
                                          : "",
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
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
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Event Details",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: const Icon(
              FontAwesomeIcons.angleLeft,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                "https://tvent.azurewebsites.net/storage/banner/${evC.DataDetailEvents['id']}/${evC.DataDetailEvents['banner']}",
              )))),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${evC.DataDetailEvents['nama_event']}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_month),
                            Text(
                              "${evC.DataDetailEvents['tanggal_pendaftaran']}",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(Icons.calendar_month),
                            Text(
                              "${evC.DataDetailEvents['tanggal_penutupan_pendaftaran']}",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(Icons.calendar_month),
                            Text(
                              "${evC.DataDetailEvents['tanggal_pelaksanaan']}",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    Container(
                      height: 90,
                      width: 130,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 1,
                              offset: Offset(0, 2),
                            )
                          ]),
                      padding: EdgeInsets.all(7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            "https://tvent.azurewebsites.net/storage/penyelenggara/logo/${evC.DataDetailEvents['penyelenggara']['id']}/${evC.DataDetailEvents['penyelenggara']['logo']}",
                            width: 30,
                            height: 30,
                          ),
                          Text(
                            "Penyelenggara",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "${evC.DataDetailEvents['penyelenggara']['nama_penyelenggara']}",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    Container(
                      width: MediaQuery.of(context).size.width - 30 - 24,
                      child: Text(
                        "${evC.DataDetailEvents['tempat']}",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${evC.DataDetailEvents['deskripsi']}",
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "List Lomba",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    runSpacing: 15,
                    children: List.generate(
                      evC.DataDetailEvents['lomba'].length,
                      (index) => InkWell(
                        onTap: () {
                          evC.GetDetailLomba(
                                  "${evC.DataDetailEvents['lomba'][index]['id']}")
                              .then(
                            (value) => {
                              evC.clearSet(),
                              _showDetailLomba(context),
                            },
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          height: MediaQuery.of(context).size.width / 2.3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(evC.DataDetailEvents['lomba']
                                          [index]['poster'] !=
                                      null
                                  ? "https://tvent.azurewebsites.net/storage/lomba/poster/${evC.DataDetailEvents['lomba'][index]['id']}/${evC.DataDetailEvents['lomba'][index]['poster']}"
                                  : "https://cdn.ebaumsworld.com/mediaFiles/picture/1151541/84693449.png"),
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
