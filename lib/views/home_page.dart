import 'package:flutter/material.dart';
import 'package:proyecto_moviles/models/communication_item.dart';
import 'package:proyecto_moviles/services/tts_services.dart';
import 'package:proyecto_moviles/services/preferences.dart';
import 'package:proyecto_moviles/data/communication_data.dart';
import 'widgets/communication_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TTSService _ttsService = TTSService();
  final PreferencesService _prefsService = PreferencesService();
  
  String _currentCategory = 'favoritos';
  List<String> _favoriteIds = ['si', 'no', 'duele', 'ayuda'];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await _prefsService.loadFavorites();
    setState(() {
      _favoriteIds = favorites;
    });
  }

  List<CommunicationItem> _getCurrentItems() {
    if (_currentCategory == 'favoritos') {
      final allItems = CommunicationData.categories.values
          .expand((items) => items)
          .toList();
      return _favoriteIds
          .map((id) => allItems.firstWhere((item) => item.id == id))
          .toList();
    }
    return CommunicationData.categories[_currentCategory] ?? [];
  }

  void _onItemTap(CommunicationItem item) {
    _ttsService.speak(item.text);
  }

  void _changeCategory(String category) {
    setState(() {
      _currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = _getCurrentItems();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_getCategoryTitle()),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.1,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return CommunicationCard(
              item: item,
              onTap: () => _onItemTap(item),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getCategoryIndex(),
        onTap: (index) {
          final categories = ['favoritos', 'comida', 'emociones', 'necesidades'];
          _changeCategory(categories[index]);
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Comida',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions),
            label: 'Emociones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: 'Necesidades',
          ),
        ],
      ),
    );
  }

  String _getCategoryTitle() {
    switch (_currentCategory) {
      case 'favoritos':
        return 'Favoritos';
      case 'comida':
        return 'Comida y Bebida';
      case 'emociones':
        return 'Emociones';
      case 'necesidades':
        return 'Necesidades';
      default:
        return 'Comunicación';
    }
  }

  int _getCategoryIndex() {
    switch (_currentCategory) {
      case 'favoritos':
        return 0;
      case 'comida':
        return 1;
      case 'emociones':
        return 2;
      case 'necesidades':
        return 3;
      default:
        return 0;
    }
  }

  @override
  void dispose() {
    _ttsService.stop();
    super.dispose();
  }
}