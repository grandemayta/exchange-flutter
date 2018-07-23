import 'package:flutter/material.dart';

class Credits extends StatefulWidget {
  @override
  createState() => CreditsState();
}

class CreditsState extends State<Credits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credits'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('https://media.licdn.com/dms/image/C4E03AQGmF6ar78rs_g/profile-displayphoto-shrink_200_200/0?e=1538006400&v=beta&t=EkfAcEwyV00DpXSRP7UT_QVQIj0P332kEzkwgXE0jFs')
                          )
                        )
                      ),
                      Divider(
                        height: 40.0,
                      ),
                      Text(
                        'Gabriel Mayta',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Text(
                        'Lead Software Developer',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black54
                        )
                      ),
                      Text(
                        'grandemayta@gmail.com',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black54
                        )
                      ),
                      Divider(
                        height: 40.0,
                      ),
                    ]
                  )
                )
              )
            ]
          )
        ]
      )
    );
  }
}
