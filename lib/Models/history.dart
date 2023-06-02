import 'package:objectbox/objectbox.dart';

@Entity()
class HistoryModel{

 int id ;
  String productId;
  String productCategory;

  HistoryModel({this.id = 0 ,required this.productId,required this.productCategory});

 }