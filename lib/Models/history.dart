import 'package:objectbox/objectbox.dart';

@Entity()
class HistoryModel{

 int id ;
  String title;

  HistoryModel({this.id = 0 ,required this.title});

 }