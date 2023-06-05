import 'package:objectbox/objectbox.dart';

@Entity()
class ActiveTradeModel{

  int id;
  String productId;
  String productCategory;

  ActiveTradeModel({this.id = 0 ,required this.productId,required this.productCategory});

 }