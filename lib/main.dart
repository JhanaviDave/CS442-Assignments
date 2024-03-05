//Created by Jhanavi Dave (A20515346)

import 'package:cs442_mp1/test2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  // implementing main function
  runApp(MaterialApp(
      title: 'NameInfo',
      theme: ThemeData(fontFamily: 'Forte'), // adding font style to all
      //Bradley Hand ITC // Blackadder ITC //Broadway //Brush Script MT //Californian FB //Copperplate Gothic'
      home: Scaffold(
          // implementing design layout
          body: SingleChildScrollView(
              // enabling scrolling vertically (defaukt)
              child: Container(
                  // creating a container class to store background color, alignment
                  decoration: BoxDecoration(
                    // defining styles for the container
                    gradient: LinearGradient(
                      // adding gradation to the background
                      colors: const [
                        Color(0xFF1C284E),
                        Color(0xFF174D7C),
                        Color(0xFF4C7D8E),
                        Color(0xFF819898),
                        Color(0xFFFF5342),
                        Color(0xFFFE6D4E),
                        Color(0xFFFF9463),
                        Color(0xFFFFC28B),
                      ],
                      begin:
                          Alignment.topCenter, // aligning the widgets from top
                      end: Alignment
                          .bottomCenter, // aligning the widgets to bottom
                    ),
                  ),
                  child: Column(children: <Widget>[
                    // calling divisonal classes in sequence for view as child of the container, keeps the content of the app aligned in a column pattern
                    Section1(
                        // displaying my details with data model classes
                        person: PersonInfo(
                      name: 'Jhanavi Dave', // my name
                      email: 'jdave6@hawk.iit.edu', // my email ID
                    )),
                    Section2(
                        // displaying my social netwrok sites/details with data model classes
                        socials: SNS(
                      instagram: '@girl_from_outerspace', // my instagram ID
                      linkedin:
                          'linkedin.com/in/jhanavi-dave', // my linkedin ID
                    )),
                    Section3(
                        // displaying details of projects implemented by me using data model class
                        projects: [
                          ProjectInfo(
                            // project 1
                            projectName: "Fabsta's Fashion Magazine",
                            timeOfImplementation: "07/2016 - 09/2016",
                          ),
                          ProjectInfo(
                            // project 2
                            projectName: "Blood Bank Management System",
                            timeOfImplementation: "06/2017 - 12/2017",
                          ),
                          ProjectInfo(
                            // project 3
                            projectName: "Smart Building System using IoT",
                            timeOfImplementation: "08/2018 - 01/2019",
                          ),
                          ProjectInfo(
                            // project 4
                            projectName: "Automated SAP JobSheet Tracking",
                            timeOfImplementation: "08/2019 - 10/2019",
                          ),
                          ProjectInfo(
                            // project 5
                            projectName: "SAP Process Automation with UiPath",
                            timeOfImplementation: "03/2021 - 05/2022",
                          ),
                        ]),
                    Section4(
                        // displaying my hobbies and interests using data model class
                        hobbies: [
                          // implementing a list of hobbies
                          'Video Games',
                          'Coding',
                          'Photography',
                          'Napping whenever I can :P',
                          'Music',
                          'Learning',
                          'Writing',
                        ]),
                    Section5(
                        // displaying some of my images using data model class
                        images: [
                          // implementing a list of images
                          ImageAsset(imagePath: 'assets/images/1.jpg'),
                          ImageAsset(imagePath: 'assets/images/2.jpg'),
                          ImageAsset(imagePath: 'assets/images/3.jpg'),
                          ImageAsset(imagePath: 'assets/images/4.jpg'),
                          ImageAsset(imagePath: 'assets/images/5.jpg'),
                          ImageAsset(imagePath: 'assets/images/6.jpg'),
                        ])
                  ]))))));
}

class Section1 extends StatelessWidget {
  //implementing class for displaying my name and email address / personal information
  final PersonInfo person; // implementing model class by variable
  Section1({required this.person});
  @override
  Widget build(BuildContext context) {
    //widget builder
    return Center(
        //align center
        child: Padding(
            padding: //create padding/space between cells
                const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical:
                        10.0), //immutable set of offsets from each side of box
            child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, // aligning and spacing between columns of the row
                children: [
                  Column(
                      //column 1 displaying my profile image
                      crossAxisAlignment: CrossAxisAlignment
                          .start, //row and column positioning child on cross axes
                      children: [
                        Image.asset(
                            'assets/images/pfp.jpg', // implementing profile image
                            height: 500,
                            width: 200)
                      ]),
                  Column(
                      // column 2 displaying my name and email ID
                      crossAxisAlignment: CrossAxisAlignment
                          .start, //row and column positioning child on cross axes
                      children: [
                        Text(
                          person.name, // name passed in main function
                          style: TextStyle(fontSize: 30), //fontsize
                        ),
                        Text(
                          person.email, // email id passed in main fucntion
                          style: TextStyle(fontSize: 30),
                        ),
                      ])
                ])));
  }
}

class Section2 extends StatelessWidget {
  //implementing class for displaying my social network links (static links)
  final SNS socials; // implementing model class by variable
  Section2({required this.socials});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            //container class for displaying SNS as second division of screen
            padding: const EdgeInsets.symmetric(
                //immutable set of offsets from each side of box
                horizontal: 10.0,
                vertical: 10.0), //create padding/space between cells
            decoration: BoxDecoration(
              //container designing - border black and 2 px thick
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            child: Column(children: [
              // displaying SNS icons with link from font_awesome_flutter package
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                //placing child widget horizontally for row and vertically for column
                // displaying instagram icon with link
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  //row and column positioning child on cross axes
                  FaIcon(
                    //Font Awesome Icon widget
                    FontAwesomeIcons.instagram, //instagram icon
                    size: 60.0,
                    color: Color.fromARGB(255, 243, 33,
                        163), //color of instagram icon alpha, red, blue, green
                  ),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  //row and column positioning child on cross axes
                  Text(
                    socials.instagram, //displaying instagram id
                    style: TextStyle(fontSize: 30),
                  ),
                ])
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                //placing child widget horizontally for row and vertically for column
                // displaying linkedin icon with link
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  FaIcon(
                    //Font Awesome Icon widget
                    FontAwesomeIcons.linkedin, //linkedin icon
                    size: 60.0,
                    color: Color.fromARGB(255, 0, 119,
                        181), //icon color for linkedin in alpha, red, blue, green
                  ),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  //row and column positioning child on cross axes
                  Text(
                    socials.linkedin, //linkedin id
                    style: TextStyle(fontSize: 30),
                  ),
                ])
              ]),
            ])));
  }
}

class Section3 extends StatelessWidget {
  //implementing class for displaying my projects from list
  final List<ProjectInfo>
      projects; // implementing model class by class variable
  Section3({required this.projects});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      // creating a container class to store background color, alignment
      padding:
          EdgeInsets.all(20.0), //immutable set of offsets from each side of box
      decoration: BoxDecoration(
        // defining styles for the container
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Column(
        children: [
          Row(
            //declaring row of table title for project and time of implementation
            mainAxisAlignment: MainAxisAlignment
                .spaceEvenly, //placing child widget horizontally for row and vertically for column
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, //row and column positioning child on cross axes
                children: [
                  Text(
                    'Project Name',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, //row and column positioning child on cross axes
                children: [
                  Text(
                    'Time of Implementation',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              )
            ],
          ),
          for (var project
              in projects) //looping 'for' to display each project with corresponding time of implementation
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, //placing child widget horizontally for row and vertically for column
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, //row and column positioning child on cross axes
                  children: [
                    Text(
                      project.projectName, //project name
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, //row and column positioning child on cross axes
                  children: [
                    Text(
                      project.timeOfImplementation, //time of implementation
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                )
              ],
            ),
        ],
      ),
    ));
  }
}

class Section4 extends StatelessWidget {
  //implementing class for displaying my hobbies and interests from list
  final List<String>
      hobbies; // implementing model class by  String variable as list
  Section4({required this.hobbies});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // creating a container class to store background color, alignment
        padding: EdgeInsets.all(
            20.0), //immutable set of offsets from each side of box
        decoration: BoxDecoration(
          // defining styles for the container
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .start, //row and column positioning child on cross axes
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              //placing child widget horizontally for row and vertically for column
              Text(
                //displaying title of list
                'Hobbies & Interests:',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
            SizedBox(height: 10.0), //creating a boz to divide sections
            ListView.builder(
              shrinkWrap:
                  true, // allows listview to consume as much space it needs on the screen
              itemCount: hobbies.length, //count list of items
              itemBuilder: (context, index) {
                //build list item widgets as key-value pair, insteading of looping 'for'
                return Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, //placing child widget horizontally for row and vertically for column
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly, //placing child widget horizontally for row and vertically for column
                        children: [
                          Text(hobbies[index],
                              style: TextStyle(
                                  fontSize:
                                      30)) //display 'index' hobby from list
                        ]),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Section5 extends StatelessWidget {
  //implementing class for displaying my hobbies and interests from list
  final List<ImageAsset> images; // implementing model class by class variable
  Section5({required this.images});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            // creating a container class to store background color, alignment

            padding: EdgeInsets.all(
                20.0), //immutable set of offsets from each side of box
            decoration: BoxDecoration(
              // defining styles for the container
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment
                  .center, //row and column positioning child on cross axes
              children: [
                // for each image in list, display as a child of the row
                for (var image in images)
                  Expanded(
                    child: Image.asset(image.imagePath),
                  ),
              ],
              // children: [
              //   Expanded(child: Image.asset('assets/images/1.jpg')),
              //   Expanded(child: Image.asset('assets/images/2.jpg')),
              //   Expanded(child: Image.asset('assets/images/3.jpg')),
              //   Expanded(child: Image.asset('assets/images/4.jpg')),
              //   Expanded(child: Image.asset('assets/images/5.jpg')),
              //   Expanded(child: Image.asset('assets/images/6.jpg')),
              // ],
            )));
  }
}
