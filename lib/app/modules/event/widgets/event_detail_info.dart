import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/controllers/event_controller.dart';
import 'package:tvent/app/modules/event/widgets/author_detail.dart';
import 'package:tvent/app/modules/event/widgets/detai_widget.dart';

class EventDetailsInfo extends StatelessWidget {
  final EventController evC = Get.find();
  final void Function(BuildContext) showDetailLomba;

  EventDetailsInfo({required this.showDetailLomba});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // _buildEventTitle(),
          _buildEventDetailsRow(),
          const SizedBox(height: 10),
          _buildEventDescription(),
          const SizedBox(height: 15),
          _buildListLombaTitle(),
          const SizedBox(height: 20),
          _buildLombaList(context),
        ],
      ),
    );
  }

  Widget _buildEventTitle() {
    return Text(
      "${evC.DataDetailEvents['nama_event']}",
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        overflow: TextOverflow.clip,
      ),
    );
  }

  Widget _buildEventDetailsRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EventDetailsWidget(evC: evC),
        AuthorsDetail(),
      ],
    );
  }

  Widget _buildEventDescription() {
    return Text(
      // 'laknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf a laknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf a laknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf a laknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf a vv laknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf a laknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf alaknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf alaknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf a laknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf a laknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf alaknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf a v vvv laknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf a v v vvvvvlaknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf alaknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf alaknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf alaknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf alaknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf av vvlaknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf alaknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf avvlaknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf alaknshljabsljfhas falsjflajs falksjflaksjf alksjfoiajsf alsnf aslkfjalsf av',
      "${evC.DataDetailEvents['deskripsi']}",
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        overflow: TextOverflow.clip,
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildListLombaTitle() {
    return Wrap(
      spacing: 10,
      children: [
        const Text(
          "List Lomba -",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${evC.DataDetailEvents['nama_event']}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildLombaList(BuildContext context) {
    return SizedBox(
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
                (value) => {evC.clearSet(), showDetailLomba(context)},
              );
            },
            child: _buildLombaContainer(index, context),
          ),
        ),
      ),
    );
  }

  Widget _buildLombaContainer(int index, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.3,
      height: MediaQuery.of(context).size.width / 1.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              evC.DataDetailEvents['lomba'][index]['poster'] != null
                  ? "https://tvent.azurewebsites.net/storage/lomba/poster/${evC.DataDetailEvents['lomba'][index]['id']}/${evC.DataDetailEvents['lomba'][index]['poster']}"
                  : "https://cdn.ebaumsworld.com/mediaFiles/picture/1151541/84693449.png",
              fit: BoxFit.cover,
            ),
          ),
          // Transparent Layer
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
              ),
            ),
          ),
          // Text
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Text(
              "${evC.DataDetailEvents['nama_lomba']}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
