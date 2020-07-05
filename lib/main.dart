
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/pokedetail.dart';
import 'package:pokemon/pokemon.dart';
import 'dart:convert';

void main() => runApp(MaterialApp(
  title: "Neelakshi's App",
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primarySwatch: Colors.cyan
  ),
  home: HomePage(),
));

class HomePage extends StatefulWidget {
  
  // This widget is the root of your application.
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
    PokeHub pokeHub;
  @override
  void initState() {
    super.initState();
    fetchData();
    
  }
  fetchData() async{
    var res = await http.get(url);
    var decodedValue = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedValue);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        centerTitle: true,
        title: Text("Poke App"),
        backgroundColor: Colors.cyan,
        ),
        body: pokeHub==null
        ?Center(
          child: CircularProgressIndicator(),
          ) :GridView.count(
          crossAxisCount: 2, 
        children: pokeHub.pokemon
        .map((Pokemon poke) => Padding(
          padding: const EdgeInsets.all(1.0),  
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PokeDetail(
                pokemon: poke,
              )));
            },
                      child: Card(
              elevation: 10.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Hero(
                    tag: poke.img,
                      child: Container(
                      height: 100.0,
                      width: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(poke.img))
                    ),
                      ),
                  ),
                    Text(poke.name,
                    style: TextStyle(
                      fontSize:22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                ],
                ),
            ),
          ),
        ))
        .toList(),
        ),
        drawer: Drawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.cyan,
          onPressed: () {},
        child: Icon(Icons.refresh),
        ),
     );
  }
}

