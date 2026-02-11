import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_example/data/person.dart';
import 'package:hive_example/domain/person_usercase.dart';
import 'package:hive_example/feature/person/bloc/person_bloc.dart';

class PersonPageProvider extends StatelessWidget {
  const PersonPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonBloc(PersonUseCaseImpl()),
      child: PersonPage(),
    );
  }
}


class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  late TextEditingController _nameController;
  late TextEditingController _nickNameController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _nickNameController = TextEditingController();
    _emit(InitEvent());
  }

  void _emit(PersonEvent event){
    context.read<PersonBloc>().add(event);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nickNameController.dispose();
    super.dispose();
  }

  void _showAddContactDialog() {
    final bloc = context.read<PersonBloc>();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Contact"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  validator: (value){
                    if(value == null ||value.isEmpty){
                      return "Please enter name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _nickNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'NickName',
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  validator: (value){
                    if(value == null ||value.isEmpty){
                      return "Please enter nickname";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  if(_formKey.currentState?.validate() ?? false){
                    _formKey.currentState?.save();
                    Person person = Person(name: _nameController.text, nickName: _nickNameController.text);
                    bloc.add(AddContact(person));
                  }
                  Navigator.of(context).pop();

                },
                child: Text("OK",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "My Contacts",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              color: Colors.purpleAccent,
              onPressed: (){
                _showAddContactDialog();
              },
              icon: Icon(Icons.person_add_alt, size: 40,)
          ),
          SizedBox(width: 6,),
        ],
      ),
        body: BlocListener<PersonBloc, PersonState>(
          listener: (context, state) {
            if (state.message.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: BlocBuilder<PersonBloc, PersonState>(
            builder: (context, state) {

              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.contactList.isEmpty) {
                return const Center(child: Text("No Contacts Found"));
              }

              return ListView.builder(
                itemCount: state.contactList.length,
                itemBuilder: (context, index) {
                  final person = state.contactList[index];

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          person.name![0].toUpperCase(),
                        ),
                      ),
                      title: Text(person.name ?? "", style: TextStyle(fontSize: 22, color: Colors.black),),
                      subtitle: Text(person.nickName ?? "",style: TextStyle(fontSize: 16, color: Colors.black)),
                    ),
                  );
                },
              );
            },
          ),
        )

    );
  }
}