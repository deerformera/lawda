import 'package:flutter/material.dart';

class Jadwal extends StatelessWidget {
  const Jadwal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 53, 58, 63),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: const JadwalColumn(),
        ),
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

  List<Widget> jadwalListItems = [];

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
      'events': [
        { 'nama': 'Upacara', 'jam': 0, 'menit':60 },
        { 'nama': 'Istirahat', 'jam': 4, 'menit':15 }
      ],
      'data': [
        { 'nama': 'B. Inggris', 'jam': 2, 'guru': 'Bu Eny' },
        { 'nama': 'Agama', 'jam': 3, 'guru': 'Bu Rumu' },
        { 'nama': 'PKK', 'jam': 3, 'guru': 'Pak Deddy' },
        { 'nama': 'PP', 'jam': 2, 'guru': 'Bu Purwani' }
      ],
      'istirahat':[4, 6],
      'jampel': 35,
    },

    'Selasa': {
      'data': [
        { 'nama': 'B. Jawa', 'jam': 2, 'guru': 'Bu Nur' },
        { 'nama': 'PJOK', 'jam': 2, 'guru': 'Pak Andi' },
        { 'nama': 'B. Inggris', 'jam': 2, 'guru': 'Bu Eny' },
        { 'nama': 'MPP', 'jam': 4, 'guru': '?' },
      ],
      'istirahat':[4, 6],
      'jampel':45
    },

    'Rabu': {
      'data': [
        { 'nama': 'Math', 'jam': 3, 'guru': 'Bu Husnul' },
        { 'nama': 'PKK', 'jam': 2, 'guru': 'Pak Deddy' },
        { 'nama': 'B. Indo', 'jam': 3, 'guru': 'Bu Lusi' },
      ],
      'istirahat':[4, 6],
      'jampel':45
    },

    'Kamis': {
      'data': [
        { 'nama': 'ASJ', 'jam': 4, 'guru': 'Bu Riya' },
        { 'nama': 'KJ', 'jam': 4, 'guru': 'Bu Riya' },
        { 'nama': 'Sejarah', 'jam': 2, 'guru': 'Bu Nunuk' },
      ],
      'istirahat':[4, 6],
      'jampel':45
    },
    
    'Jumat': {
      'data': [
        { 'nama': 'PPJ', 'jam': 3, 'guru': 'Pak Heri' },
        { 'nama': 'TKJN', 'jam': 3, 'guru': 'Pak Heri' },
        { 'nama': 'PKPJ', 'jam': 4, 'guru': 'Pak Deddy' },
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
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4)), borderSide: BorderSide(color: Color.fromARGB(255, 201, 242, 252))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4)), borderSide: BorderSide(color: Color.fromARGB(255, 201, 242, 252))),
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4)), borderSide: BorderSide(color: Color.fromARGB(255, 201, 242, 252)))
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
      child: Text('Empty', style: TextStyle(color: Color.fromARGB(255, 201, 242, 252))),
    );

    if (Mapel[selectedHari] != null){
      jadwalListItems = [];
      List istirahat = [3, 6];

      List.generate(Mapel[selectedHari]!['data'].length, (index){
        DateTime seven = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 7);
        int tambahan = 0;
        int tambahan_akhir = 0;
        int jampel = this.Mapel[selectedHari]!['jampel'];

        for (var i = 0; i < index; i++) {
          int jam = this.Mapel[selectedHari]!['data'][i]['jam'];
          tambahan += jam;
        };

        tambahan_akhir = tambahan + Mapel[selectedHari]!['data'][index]['jam'] as int;


        DateTime awal = seven.add(Duration(minutes: tambahan * jampel));
        DateTime akhir = awal.add(Duration(minutes: Mapel[selectedHari]!['data'][index]['jam'] * jampel));
        bool active = DateTime.now().isAfter(awal) && DateTime.now().isBefore(akhir);


        jadwalListItems.add(JadwalItem(data: Mapel[selectedHari]!['data'][index], active: active));
      });
    } else {
      jadwalListItems = [jadwalEmpty];
    }

    var jadwalList = Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: jadwalListItems
      ),
    );


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
  final bool active;

  const JadwalItem({super.key, required this.data, required this.active});

  @override
  State<JadwalItem> createState() => _JadwalItemState();
}

class _JadwalItemState extends State<JadwalItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(25,0,0,0),
        borderRadius: BorderRadius.circular(4),
        border: widget.active ? Border.all(color: Color.fromARGB(255, 201, 242, 252)) : null
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.data['nama'], style: TextStyle(color: Color.fromARGB(255, 201, 242, 252))),
          SizedBox(height: 12),
          Text(widget.data['guru'], style: TextStyle(color: Color.fromARGB(175, 201, 242, 252)), textAlign: TextAlign.end)
        ],
      ),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 8),
    );
  }
}