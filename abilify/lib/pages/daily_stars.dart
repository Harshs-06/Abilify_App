

import 'package:abilify/pages/child_home_page.dart';
import 'package:abilify/pages/continue_as.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DailyStars extends StatefulWidget{
  const DailyStars({super.key});

  @override
  _DailyStarsState createState() => _DailyStarsState();
}

class _DailyStarsState extends State<DailyStars>{
  @override
  bool col=false;
  bool col2=false;
  bool col3=false;
  bool col4=false;
  bool col5=false;
 

 @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Color.fromARGB(255, 251, 239, 215),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Column( 
          children: [
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 6.0),
              child: Row(
                children: [
                  // BackButtonIcon(
                  //   key:
                  // ),

                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ChildHomePage()));
                  }, 
                  icon: Icon(Icons.arrow_back,
                  color: Colors.black,
                  size: 30.0,
                  weight: 100.0,),
                  ),
              
                  SizedBox(
                    width: 240,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Daily Stars',
                                // textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                )
                            ),
                          ),
                      
                           Align(
                            alignment: Alignment.centerLeft,
                             child: Text('Complete challenegs to earn stars',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                )
                                ),
                           ),

                        ],
                      ),
                    ),
                  ),              
              
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      padding: EdgeInsets.only(left: 30, right: 40, top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        // shape: ,
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange,
                      ),
                      
                    ),
                  ),
                ],
              ),

            ),

            SizedBox(height: 16,),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Column(
                    children: [
                      Container(
                        width: 350,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 255, 237, 202),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                child: Text('Todays Progress ',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  )
                                  ),
                              ),
                            ),

                            LinearPercentIndicator(
                              lineHeight: 20,
                              percent: 0.7,
                              barRadius: Radius.circular(20),
                              progressColor: Colors.deepOrange,
                              backgroundColor: Colors.deepOrange.shade100,
                              animation: true,
                              animationDuration: 4000,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0), 
                  child: Column(
                    children: [

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: Text( 'Daily Challenges',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ) 
                          ),
                        ),
                      ), 


                      Container(
                          width: 350,
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border(left:BorderSide(color:col? const Color.fromARGB(243, 0, 148, 17):Colors.white,width: 10)),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                   Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, top: 10),
                                      child: Text("Daily Login",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text("open abilify app today",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Transform.scale(
                                scale: 1.3,
                                child: Checkbox(value: col, activeColor: Colors.green, shape: CircleBorder(),
                                onChanged: (ischecked){
                                  setState(() {
                                    if(ischecked==true){
                                      col=true;
                                    }else{
                                      col=false;
                                    }
                                  });
                                }),
                              )
                            ],
                          ),
                        ),


                        SizedBox(height: 10,),
                          Container(
                          width: 350,
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border(left:BorderSide(color:col2? const Color.fromARGB(243, 0, 148, 17):Colors.white,width: 10)),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, top: 10),
                                      child: Text("Play Games",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text("Play atleast one game today",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Transform.scale(
                                scale: 1.3,
                                child: Checkbox(value: col2, activeColor: Colors.green, shape: CircleBorder(),
                                onChanged: (ischecked){
                                  setState(() {
                                    if(ischecked==true){
                                      col2=true;
                                    }else{
                                      col2=false;
                                    }
                                  });
                                }),
                              )
                            ],
                          ),
                        ),

                        SizedBox(height: 10,),

                        Container(
                          width: 350,
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border(left:BorderSide(color:col3? const Color.fromARGB(243, 0, 148, 17):Colors.white,width: 10)),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                   Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, top: 10),
                                      child: Text("Listen to Music",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text("Explore a music activity for 5 minutes",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Transform.scale(
                                scale: 1.3,
                                child: Checkbox(value: col3, activeColor: Colors.green, shape: CircleBorder(),
                                onChanged: (ischecked){
                                  setState(() {
                                    if(ischecked==true){
                                      col3=true;
                                    }else{
                                      col3=false;
                                    }
                                  });
                                }),
                              )
                            ],
                          ),
                        ),


                        SizedBox(height: 10,),



                        Container(
                          width: 350,
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border(left:BorderSide(color:col4? const Color.fromARGB(243, 0, 148, 17):Colors.white,width: 10)),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                   Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, top: 10),
                                      child: Text("Read a Story",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text("Complete one Story from Story time",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Transform.scale(
                                scale: 1.3,
                                child: Checkbox(value: col4, activeColor: Colors.green, shape: CircleBorder(),
                                onChanged: (ischecked){
                                  setState(() {
                                    if(ischecked==true){
                                      col4=true;
                                    }else{
                                      col4=false;
                                    }
                                  });
                                }),
                              )
                            ],
                          ),
                        ),


                        SizedBox(height: 10,),



                        Container(
                          width: 350,
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border(left:BorderSide(color:col5? const Color.fromARGB(243, 0, 148, 17):Colors.white,width: 10)),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                   Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10, top: 10),
                                      child: Text("Practice Skills",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text("Complete a learning activity",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Transform.scale(
                                scale: 1.3,
                                child: Checkbox(value: col5, activeColor: Colors.green, shape: CircleBorder(),
                                onChanged: (ischecked){
                                  setState(() {
                                    if(ischecked==true){
                                      col5=true;
                                    }else{
                                      col5=false;
                                    }
                                  });
                                }),
                              )
                            ],
                          ),
                        ),


                        SizedBox(height: 18,),


                        Container(
                          width: 350,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20,  top: 15),
                                child: Column(
                                  children: [
                                    Text('Rewards Shop',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text('Collect stars to unlock special rewards and features!',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                      ),
                                    )

                                  ],
                                ),
                              ),


                              Container(

                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
    ),
    ),
   );
 } 
}