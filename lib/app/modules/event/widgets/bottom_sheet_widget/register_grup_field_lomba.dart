import 'package:flutter/material.dart';

class RegisterGrupFieldLombaBottomSheet extends StatelessWidget {
  final int numberOfTeamMembers;
  RegisterGrupFieldLombaBottomSheet(
      {super.key, required this.numberOfTeamMembers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          "Register",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          "Register your team to join this competition",
          textAlign: TextAlign.center,
        ),
        // make text field for group name
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Group Name",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Enter your group name",
            ),
          ),
        ),

        const SizedBox(height: 20),
        leaderField(),
        for (int i = 0; i < (numberOfTeamMembers - 1); i++) memberField(i),
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Join"),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Close"),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

Widget leaderField() {
  return Column(
    children: [
      const Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Team Leader Name",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: TextFormField(
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Enter your name",
          ),
        ),
      ),
    ],
  );
}

Widget memberField(int index) {
  return Column(
    children: [
      const SizedBox(height: 20),
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          "Member ${index + 1} Name",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: TextFormField(
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Enter your name",
          ),
        ),
      ),
    ],
  );
}
