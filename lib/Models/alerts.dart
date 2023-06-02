import 'package:objectbox/objectbox.dart';

@Entity()
class AlertModel{

 int id ;
  String notification;

  AlertModel({this.id = 0 ,required this.notification});

 }