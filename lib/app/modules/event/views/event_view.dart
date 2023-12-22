import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/event_controller.dart';

class EventView extends GetView<EventController> {
  EventView({super.key});

  @override
  final EvC = Get.put(EventController());
  RxBool checkDetails = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        EvC.choseKategori.value = "Sport";
                        EvC.GetEvent(EvC.choseKategori.value);
                      },
                      child: Obx(
                        () => Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          height: 50,
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: EvC.choseKategori.value == "Sport"
                                ? Colors.orange
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.emoji_events,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Sports',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        EvC.choseKategori.value = "Akademik";
                        EvC.GetEvent(EvC.choseKategori.value);
                      },
                      child: Obx(
                        () => Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          height: 50,
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: EvC.choseKategori.value == "Akademik"
                                ? Colors.orange
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.chrome_reader_mode,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Akademik',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        EvC.choseKategori.value = "Programming";
                        EvC.GetEvent(EvC.choseKategori.value);
                      },
                      child: Obx(
                        () => Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          height: 50,
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: EvC.choseKategori.value == "Programming"
                                ? Colors.orange
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.computer,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Programming',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        EvC.choseKategori.value = "Art";
                        EvC.GetEvent(EvC.choseKategori.value);
                      },
                      child: Obx(
                        () => Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          height: 50,
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: EvC.choseKategori.value == "Art"
                                ? Colors.orange
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.draw,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Art',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    "Best ${EvC.choseKategori.value} Event",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // EvC.GetEvent();
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Obx(
              () => Column(
                children: List.generate(
                  EvC.DataKategoriEvents.length,
                  (index) => InkWell(
                    onTap: () {
                      EvC.GetDetailEvent(
                              "${EvC.DataKategoriEvents[index]['id']}")
                          .then(
                        (value) => Get.to(() => details()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            "https://tvent.azurewebsites.net/storage/banner/${EvC.DataKategoriEvents[index]['id']}/${EvC.DataKategoriEvents[index]['banner']}",
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  EvC.DataKategoriEvents[index]['nama_event'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  EvC.DataKategoriEvents[index]['deskripsi'],
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Image.network(
                                      "https://tvent.azurewebsites.net/storage/penyelenggara/logo/${EvC.DataKategoriEvents[index]['penyelenggara']['id']}/${EvC.DataKategoriEvents[index]['penyelenggara']['logo']}",
                                      width: 30,
                                      height: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          EvC.DataKategoriEvents[index]
                                                  ['penyelenggara']
                                              ['nama_penyelenggara'],
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          EvC.DataKategoriEvents[index]
                                              ['tempat'],
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
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
    );
  }
}

class details extends StatefulWidget {
  const details({super.key});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final EvC = Get.put(EventController());

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
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "${EvC.DetailLomba['nama_lomba']}",
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
                              image: NetworkImage(EvC.DetailLomba['poster'] !=
                                      null
                                  ? "https://tvent.azurewebsites.net/storage/lomba/poster/${EvC.DetailLomba['id']}/${EvC.DetailLomba['poster']}"
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
                          Text("Room : ${EvC.DetailLomba['ruangan_lomba']}"),
                          Text("Group : ${EvC.DetailLomba['max_anggota']}"),
                          Text(
                              "Kuota : ${EvC.DetailLomba['anggota_terdaftar']} / ${EvC.DetailLomba['kuota_lomba']}"),
                          Text(
                              "Start At :${EvC.DetailLomba['pelaksanaan_lomba'].toString().substring(0, 10)}"),
                          Text(
                              "${EvC.DetailLomba['pelaksanaan_lomba'].toString().substring(11, 19)}"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text("${EvC.DetailLomba['keterangan']}"),
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
                    controller: EvC.namaGroup,
                    decoration: InputDecoration(
                      label: Text("Nama Group"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: EvC.cariKetua,
                    onChanged: (value) {
                      EvC.GetUsers(value).then(
                        (value) => {
                          EvC.ketuaCombox.value = value,
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
                      visible: EvC.ketuaCombox.isNotEmpty,
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
                              EvC.ketuaCombox.length,
                              (index) {
                                return Obx(
                                  () => ListTile(
                                    onTap: () {
                                      setState(() {
                                        EvC.cariKetua.text =
                                            "${EvC.ketuaCombox[index]['name']}";
                                        EvC.ketuaCombox.clear();
                                      });
                                    },
                                    title: Text(
                                      EvC.ketuaCombox.isNotEmpty
                                          ? "${EvC.ketuaCombox[index]['name']}"
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
                    controller: EvC.cariAnggota,
                    onChanged: (value) {
                      EvC.GetUsers(value).then((value) {
                        value.removeWhere(
                            (element) => element['name'] == EvC.cariKetua.text);
                        EvC.PesertaCombox.value = value;
                      });
                      if (EvC.cariAnggota.text == "") {
                        EvC.PesertaCombox.clear();
                      }
                    },
                    decoration: InputDecoration(
                      label: Text("Cari Anggota"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: EvC.PesertaCombox.isNotEmpty,
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
                              EvC.PesertaCombox.length,
                              (index) {
                                return Obx(
                                  () => ListTile(
                                    onTap: () {
                                      setState(() {
                                        EvC.cariAnggota.text =
                                            "${EvC.PesertaCombox[index]['name']}";
                                        EvC.PesertaCombox.clear();
                                      });
                                    },
                                    title: Text(
                                      EvC.PesertaCombox.isNotEmpty
                                          ? "${EvC.PesertaCombox[index]['name']}"
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
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Event Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
      ),
      body: ListView(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                "https://tvent.azurewebsites.net/storage/banner/${EvC.DataDetailEvents['id']}/${EvC.DataDetailEvents['banner']}",
              )))),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${EvC.DataDetailEvents['nama_event']}",
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
                              "${EvC.DataDetailEvents['tanggal_pendaftaran']}",
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
                              "${EvC.DataDetailEvents['tanggal_penutupan_pendaftaran']}",
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
                              "${EvC.DataDetailEvents['tanggal_pelaksanaan']}",
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
                            "https://tvent.azurewebsites.net/storage/penyelenggara/logo/${EvC.DataDetailEvents['penyelenggara']['id']}/${EvC.DataDetailEvents['penyelenggara']['logo']}",
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
                            "${EvC.DataDetailEvents['penyelenggara']['nama_penyelenggara']}",
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
                        "${EvC.DataDetailEvents['tempat']}",
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
                  "${EvC.DataDetailEvents['deskripsi']}",
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
                      EvC.DataDetailEvents['lomba'].length,
                      (index) => InkWell(
                        onTap: () {
                          EvC.GetDetailLomba(
                                  "${EvC.DataDetailEvents['lomba'][index]['id']}")
                              .then(
                            (value) => {
                              EvC.clearSet(),
                              _showDetailLomba(context),
                            },
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          height: MediaQuery.of(context).size.width / 2.3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(EvC.DataDetailEvents['lomba']
                                          [index]['poster'] !=
                                      null
                                  ? "https://tvent.azurewebsites.net/storage/lomba/poster/${EvC.DataDetailEvents['lomba'][index]['id']}/${EvC.DataDetailEvents['lomba'][index]['poster']}"
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
