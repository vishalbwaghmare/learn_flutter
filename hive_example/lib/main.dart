import 'package:flutter/material.dart';
import 'package:hive_example/person.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  var personBox = await Hive.openBox<Person>('personBox');

  Person person = Person.fromJson({
    'name': 'Vishal',
    'nickName': 'Sopan'
  });
  await personBox.put('john', person);

  Person? personExample = personBox.get("john");

  print(personExample?.nickName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Hive demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Person>('personBox').listenable(),
          builder: (context, Box<Person> box , _){
            final person = box.get('john');

            if(person == null){
              return Center(child: Text('No user found'));
            }
            return Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    'Name: ${person.name}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nickname: ${person.nickName}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            );
          })
    );
  }
}
