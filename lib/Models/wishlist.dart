import 'package:objectbox/objectbox.dart';

@Entity()
class WishlistModel{

  int id ;
  String productId;
  String productCategory;

  WishlistModel({this.id = 0 ,required this.productId,required this.productCategory});

 }