import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Jadwal extends StatelessWidget {
  const Jadwal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 53, 58, 63),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: const JadwalColumn(),
      )
    );
  }
}

class JadwalColumn extends StatefulWidget {
  const JadwalColumn({super.key});

  @override
  State<JadwalColumn> createState() => _JadwalColumnState();
}

class _JadwalColumnState extends State<JadwalColumn> {
  String? selectedHari;

  DateTime seven = new DateTime.now();

  final List<String> hari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
  ];

  @override
  void initState() {
    seven = new DateTime(seven.year, seven.month, seven.day, 7, 0, 0, 0, 0);
    int weekday = DateTime.now().weekday - 1;
    if (weekday <= 4){
      selectedHari = hari[weekday];
    } else {
      selectedHari = null;
    }

    super.initState();
  }

  Map<String, Map> Mapel = {
    'Senin': {
      'data': [
        { 'nama': 'B. Inggris', 'jam': 2, 'guru': 'lorem' },
        { 'nama': 'Agama', 'jam': 3, 'guru': 'lorem' },
        { 'nama': 'PKK', 'jam': 3, 'guru': 'lorem' },
        { 'nama': 'PP', 'jam': 2, 'guru': 'lorem' }
      ],
      'istirahat':[4, 6],
      'jampel': 35,
    },

    'Selasa': {
      'data': [
        { 'nama': 'B. Jawa', 'jam': 2, 'guru': 'lorem' },
        { 'nama': 'PJOK', 'jam': 2, 'guru': 'lorem' },
        { 'nama': 'B. Inggris', 'jam': 2, 'guru': 'lorem' },
        { 'nama': 'MPP', 'jam': 4, 'guru': 'lorem' },
      ],
      'istirahat':[4, 6],
      'jampel':45
    },

    'Rabu': {
      'data': [
        { 'nama': 'Math', 'jam': 3, 'guru': 'lorem' },
        { 'nama': 'PKK', 'jam': 2, 'guru': 'lorem' },
        { 'nama': 'B. Indo', 'jam': 3, 'guru': 'lorem' },
      ],
      'istirahat':[4, 6],
      'jampel':45
    },

    'Kamis': {
      'data': [
        { 'nama': 'ASJ', 'jam': 4, 'guru': 'lorem' },
        { 'nama': 'KJ', 'jam': 4, 'guru': 'lorem' },
        { 'nama': 'Sejarah', 'jam': 2, 'guru': 'lorem' },
      ],
      'istirahat':[4, 6],
      'jampel':45
    },
    
    'Jumat': {
      'data': [
        { 'nama': 'PPJ', 'jam': 3, 'guru': 'lorem' },
        { 'nama': 'TKJN', 'jam': 3, 'guru': 'lorem' },
        { 'nama': 'PKPJ', 'jam': 4, 'guru': 'lorem' },
      ],
      'istirahat':[4, 7],
      'jampel':35
    },
  };

  @override
  Widget build(BuildContext context) {

    var jadwalDropdown = DropdownButtonFormField(
      dropdownColor: Color.fromARGB(255, 53, 58, 63),      
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 201, 242, 252))),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 201, 242, 252))),
        border: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 201, 242, 252)))
      ),
      style: TextStyle(color: Color.fromARGB(255, 201, 242, 252)),
      value: selectedHari,
      onChanged: (value) => {
        setState(() => selectedHari = value as String)
      },
      items: hari.map((String item){
        return DropdownMenuItem(
          value: item,
          child: Text(item)
        );
      }).toList(),
    );
    
    var jadwalEmpty = const Center(
      child: Text('Empty'),
    );

    var jadwalList = selectedHari != null ? Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(Mapel[selectedHari]!['data'].length, (index){
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(border: Border.all(width: 1, color: Color.fromARGB(255, 201, 242, 252)), borderRadius: BorderRadius.circular(2)),
            child: JadwalItem(data: Mapel[selectedHari]!['data'][index], jampel: Mapel[selectedHari]!['jampel']),
          );
        })
      ),
    ) : jadwalEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: jadwalDropdown
        ),

        jadwalList
      ]
    );
  }
}

class JadwalItem extends StatefulWidget {
  final Map data;
  final int jampel;

  const JadwalItem({super.key, required this.data, required this.jampel});

  @override
  State<JadwalItem> createState() => _JadwalItemState();
}

class _JadwalItemState extends State<JadwalItem> {
  bool active = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.data!['nama'], style: TextStyle(color: Color.fromARGB(255, 201, 242, 252))),
      padding: EdgeInsets.all(20),
    );
  }
}