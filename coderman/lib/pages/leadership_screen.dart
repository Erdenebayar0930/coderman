import 'package:flutter/material.dart';

class Leader {
  final String name;
  final int points;
  final int rank;
  final bool isMe;

  Leader({
    required this.name,
    required this.points,
    required this.rank,
    this.isMe = false,
  });
}

class LeadershipScreen extends StatelessWidget {
  LeadershipScreen({super.key});

  // ---------------------------
  // MOCK DATA
  // ---------------------------
  final List<Leader> leaders = List.generate(
    60,
    (i) => Leader(
      name: "User ${i + 1}",
      points: 10000 - i * 50,
      rank: i + 1,
      isMe: i == 27, // 🔥 өөрийгөө энд тэмдэглэнэ (rank 28)
    ),
  );

  @override
  Widget build(BuildContext context) {
    final top3 = leaders.where((e) => e.rank <= 3).toList();
    final others = leaders.where((e) => e.rank > 3 && e.rank <= 50).toList();
    final me = leaders.firstWhere((e) => e.isMe);

    // Хэрвээ өөрийн rank > 50 бол сүүлд харуулна
    if (me.rank > 50) {
      others.add(me);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFEFF4FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              _buildTitle(),
              const SizedBox(height: 32),
              _buildTop3(top3),
              const SizedBox(height: 32),
              _buildList(others),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------
  // TITLE
  // ---------------------------
  Widget _buildTitle() {
    return Column(
      children: const [
        Text(
          "CODERMAN",
          style: TextStyle(
            fontSize: 14,
            letterSpacing: 2,
            color: Colors.blueGrey,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Dev C++ Манлайлагчид",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "Шилдэг кодчдын жагсаалт",
          style: TextStyle(color: Colors.black54),
        ),
      ],
    );
  }

  // ---------------------------
  // TOP 3 PODIUM
  // ---------------------------
  Widget _buildTop3(List<Leader> top3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _podiumItem(top3[1], height: 120, color: Colors.blueGrey),
        _podiumItem(top3[0], height: 160, color: Colors.amber),
        _podiumItem(top3[2], height: 120, color: Colors.brown),
      ],
    );
  }

  Widget _podiumItem(
    Leader leader, {
    required double height,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: const Icon(Icons.emoji_events, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(leader.name),
        Text(
          "${leader.points} pts",
          style: const TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 8),
        Container(
          width: 70,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withOpacity(0.85),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "${leader.rank}",
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------
  // LIST 4–50
  // ---------------------------
  Widget _buildList(List<Leader> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, i) {
        final leader = list[i];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: leader.isMe ? Colors.blue.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: leader.isMe
                ? Border.all(color: Colors.blue, width: 2)
                : null,
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Row(
            children: [
              Text(
                "${leader.rank}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(leader.name, style: const TextStyle(fontSize: 16)),
              ),
              Text(
                "${leader.points} pts",
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        );
      },
    );
  }
}
