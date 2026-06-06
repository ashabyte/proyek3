class TemaItem {
  final String name;
  final List<LokasiSlot> lokasiSlots;

  const TemaItem({required this.name, required this.lokasiSlots});
}

class LokasiSlot {
  final String name;
  final String duration;

  const LokasiSlot({required this.name, required this.duration});
}