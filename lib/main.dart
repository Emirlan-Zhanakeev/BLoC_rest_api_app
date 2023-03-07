import 'package:bloc_rest_api/bloc/user_bloc.dart';
import 'package:bloc_rest_api/bloc/user_state.dart';
import 'package:bloc_rest_api/model/user_model.dart';
import 'package:bloc_rest_api/pages/details_screen.dart';
import 'package:bloc_rest_api/repos/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLoC',
      theme: ThemeData(
        brightness: Brightness.dark,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        // useMaterial3: true,
      ),

      ///if we want load them from server, we use RepositoryProvider;
      home: RepositoryProvider(
        create: (BuildContext context) => UserRepository(),
        child: const HomePage(),
      ),

      /// where we inject data
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<UserRepository>(context),
      )..add(LoadUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BLoC'),
          centerTitle: true,
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserLoadedState) {
              List<UserModel> userList = state.users;
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              e: userList[index],
                            ),
                           ),
                        );
                      },
                      child: Card(
                        // color: Colors.grey,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(
                              '${userList[index].name}: ${userList[index].username}'),
                          subtitle: Text(userList[index].email),
                          trailing: Text(userList[index].id.toString()),
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            if (state is UserErrorState) {
              return const Center(
                child: Text(
                  "ERROR 404",
                  style: TextStyle(fontSize: 30, color: Colors.red),
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
