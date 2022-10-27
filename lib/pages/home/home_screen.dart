import 'package:e_commerce/bloc/lawyers/lawyers_bloc.dart';
import 'package:e_commerce/db/model/lawyer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        leading: const Icon(Icons.menu, color: Colors.white, size: 24,),
        title: const Text("Ecommerce", style: TextStyle(fontSize: 21, color: Colors.white),),
        centerTitle: true,
        actions:  [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white,size: 24,),
            splashRadius: 16,
            onPressed: (){},)
        ],
      ),
      body: Column(
        children: [
          Container(
            color: primary,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(blunt)
              ),
              child: Row(
                children: [
                  const Icon(Icons.date_range, color: promptColor,),
                  const Expanded(child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("Select Date and Time"),
                  )),
                  Container(color: promptColor,height: 30,),
                  const Icon(Icons.sort)
                ],
              ),
            ),
          ),

          Expanded(child: BlocBuilder<LawyersBloc, LawyersState>(
            builder: (_,state){
              if(state is LawyersLoading){
                return const LawyersListBuilder(isLoading: true);
              }else if(state is LawyersFetched){
                return LawyersListBuilder(isLoading: false, lawyers: state.lawyers);
              }else{
                return const SizedBox.shrink();
              }
            },
          )),

          Row(
              children: [
                Expanded(child: ElevatedButton(
                    onPressed: (){},
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
                        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero
                        )),
                      backgroundColor: MaterialStateProperty.all(success)
                    ),
                    child: const Text(
                      "OPTIMIZE ROUTE",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),
                    )
                )),
                Expanded(child: ElevatedButton(
                    onPressed: (){},
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
                        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero
                        )),
                        backgroundColor: MaterialStateProperty.all(error)
                    ),
                    child: const Text(
                      "RESET",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),
                    )
                ))
              ],
            ),
        ],
      ),
    );
  }
}

class LawyersListBuilder extends StatelessWidget {
  final List<Lawyer>? lawyers;
  final bool isLoading;
  const LawyersListBuilder({Key? key, this.lawyers, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.fromLTRB(10,10,10,70),
        itemCount: isLoading ? 1 : lawyers!.length,
        shrinkWrap: true,
        itemBuilder: (_,index){
          return isLoading
              ? const Center(child: SizedBox(
                width: 30, height: 30,
                child: CircularProgressIndicator(color: primary,),
              ))
              : LawyersItem(
            lawyer: lawyers![index],
          );
        },
        separatorBuilder: (_,index){
          return const Divider();
        }
    );
  }
}

class LawyersItem extends StatelessWidget {
  final Lawyer lawyer;
  const LawyersItem({Key? key, required this.lawyer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      },
      child: Card(
        elevation: 4,
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(lawyer.phone_no, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                    Text(lawyer.email, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12))
                  ],
                ),
                const Divider(color: Colors.transparent, height: 8,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(lawyer.profile_picture), radius: 26,),
                    const SizedBox(width: 8,),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(lawyer.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                            const SizedBox(height: 4,),
                            Text(lawyer.bio, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                          ],
                        ))
                  ],
                ),
                const SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBarIndicator(
                        rating: double.parse(lawyer.rating.isNotEmpty?lawyer.rating:"0"),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 16.0,
                        direction: Axis.horizontal,
                      ),

                      Text("Ranking: ${lawyer.ranking}", style: const TextStyle(
                          color: Colors.indigoAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                ),

              ],
            ),
          )
      ),
    );
  }
}

