import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphosis_flutter_demo/non_ui/bloc/cocktail_cubit.dart';
import 'package:morphosis_flutter_demo/non_ui/locator/locator.dart';
import 'package:morphosis_flutter_demo/non_ui/model/cocktail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchTextField = TextEditingController();
  final cocktailCubit = locator<CocktailCubit>();

  @override
  void initState() {
    _searchTextField.text = "";
    super.initState();
  }

  @override
  void dispose() {
    _searchTextField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* In this section we will be testing your skills with network and local storage. You need to fetch data from any open source api from the internet.
             E.g:
             https://any-api.com/
             https://rapidapi.com/collection/best-free-apis?utm_source=google&utm_medium=cpc&utm_campaign=Beta&utm_term=%2Bopen%20%2Bsource%20%2Bapi_b&gclid=Cj0KCQjw16KFBhCgARIsALB0g8IIV107-blDgIs0eJtYF48dAgHs1T6DzPsxoRmUHZ4yrn-kcAhQsX8aAit1EALw_wcB
             Implement setup for network. You are free to use package such as Dio, Choppper or Http can ve used as well.
             Upon fetching the data try to store thmm locally. You can use any local storeage.
             Upon Search the data should be filtered locally and should update the UI.
            */
            CupertinoSearchTextField(
              controller: _searchTextField,
            ),
            Expanded(
              child: BlocBuilder<CocktailCubit, CocktailState>(
                builder: (context, state) {
                  if (state.error != null) {
                    return Center(
                      child: Text(
                        state.error!,
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (state.loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.loadedCocktails != null) {
                    return _loadedCocktails(state.loadedCocktails!);
                  }
                  return Text(
                    "Call any api you like from open apis and show them in a list. ",
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadedCocktails(List<Cocktail> cocktails) {
    return ValueListenableBuilder<TextEditingValue>(
        valueListenable: _searchTextField,
        builder: (context, searchWord, child) {
          // filter cocktails by search value
          final filteredCocktails = cocktails
              .where((element) => element.name
                  .toLowerCase()
                  .contains(searchWord.text.toLowerCase()))
              .toList();

          return RefreshIndicator(
            onRefresh: () async => cocktailCubit.reloadOrdinaryDrinks(),
            child: ListView.builder(
              padding: EdgeInsets.only(top: 20),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: filteredCocktails.length,
              itemBuilder: (_, i) {
                final cocktail = filteredCocktails[i];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(cocktail.image),
                  ),
                  title: Text(cocktail.name),
                  subtitle: Text(cocktail.id),
                );
              },
            ),
          );
        });
  }
}
