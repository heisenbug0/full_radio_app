// ignore_for_file: non_constant_identifier_names

class ReplaysTable {
  int id;
  String image_url;
  String title;
  String description;
  String scheduled_for;
  int status;

  ReplaysTable({
    required this.id,
    required this.image_url,
    required this.title,
    required this.description,
    required this.scheduled_for,
    required this.status,
  });
}

final List<ReplaysTable> replaysTable = [
  ReplaysTable(
    id: 1,
    image_url: 'assets/program-flyers-2.png',
    title: 'Working in the farm',
    description: 'Dr Eze Obi will be taking us on farm works',
    scheduled_for: '04-07-2021 18:25',
    status: 1,
  ),
  ReplaysTable(
    id: 2,
    image_url: 'assets/program-flyers-1.png',
    title: 'Harvesting Onion',
    description: 'Agro specialist Ebenezer 1 will be making a brief on harvesting onion',
    scheduled_for: '30-07-2021 18:25',
    status: 1,
  ),
  ReplaysTable(
    id: 3,
    image_url: 'assets/program-flyers-2.png',
    title: 'Eating during work',
    description: 'CEO wants everyone to learn the official learn',
    scheduled_for: '9-07-2021 18:25',
    status: 1,
  ),
  ReplaysTable(
    id: 4,
    image_url: 'assets/program-flyers-3.png',
    title: 'Winning Farmers',
    description: 'We want to give a major shout out to all the winners of the new government scheme',
    scheduled_for: '28-07-2021 18:25',
    status: 1,
  ),
  ReplaysTable(
    id: 5,
    image_url: 'assets/program-flyers-1.png',
    title: 'The Digital Farmer',
    description: 'This is an introduction to the works of Bellefu Radio',
    scheduled_for: '14-07-2021 18:25',
    status: 1,
  ),
];
