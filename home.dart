import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
 
  TextEditingController reviewController = TextEditingController();
  double rate = 2;
  List<TaskModel> list =
  [
    TaskModel('Solve two Problems', true),
    TaskModel('Flutter Task', false)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
           Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Image(image: AssetImage('assets/images/cat.jpg')),
          )
        ],
      ),
      body: Stack(
  children: <Widget>[
    const SizedBox(
      width: double.infinity,
      height: 600,
    ),
    SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
            const Text('Today',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 34,
            ),),
            ...List.generate(list.length
                    , (index) => taskWidget(
                        list[index].done,
                        list[index].content,
                        ()
                        {
                         setState(()
                         {
                           list.removeAt(index);
                         });
                        },(bool Do){
                          setState(() {
                            list[index].done=Do;
                          });
                        }
            )),
            const SizedBox(height: 40,),
            
                    ],
                  ),
          )
    ),
    Positioned(
              right: 10,
              bottom:10,
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                child:const  Icon(Icons.add),
                onPressed: (){
                  showDialog(
                        context: context,
                        builder:(context) {
                          return AlertDialog
                            (
                            title: const Text("Task Title"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children:
                              [
                                 TextField(
                                  controller: reviewController,
                                ),
                                const SizedBox(height: 20,),
            
            
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF000000),
                                      fixedSize: const Size(343, 48),
                                    ),
            
                                    onPressed: ()
                                    {
                                      setState(()
                                      {
                                       list.add(TaskModel(reviewController.text,false)) ;
                                      });
                                    }, child: const Text("ADD" ,
                                style: TextStyle(
                                   color: Colors.white
                                ),
                                ))
                              ],
                            ),
                          );
                        }, );
            
                }
                )
            )

  ]
 )
    );
  }
}
class TaskModel{
   bool done;
  String content;
  TaskModel(this.content , this.done);
}

Widget taskWidget(bool done,String content, Function deleteFunction, Function doneFunction){
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Row(
      children: [
        Checkbox(value: done ,onChanged:(bool){ doneFunction(!done);} ),
        const SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(content,
            style: !done? 
            const TextStyle(color:Color(0xFF737373),fontSize: 15,fontWeight: FontWeight.w500 ):
            const TextStyle(color:Color.fromARGB(123, 115, 115, 115),fontSize: 15,fontWeight: FontWeight.w500 ,decoration: TextDecoration.lineThrough),
            ),
            const Text('12:42 pm',style:
              TextStyle(color:Color.fromARGB(192, 115, 115, 115),fontSize: 15,fontWeight: FontWeight.w500 ),)
          ],
        ),
        const Spacer(),
        IconButton(onPressed: ()
        {
          deleteFunction();
        }, icon: const Icon(Icons.delete ,
          color: Colors.red,
        )),
      ],
       
    ),
  );
}