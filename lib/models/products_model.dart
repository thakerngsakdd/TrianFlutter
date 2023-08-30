import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductsModel {
  final String id;
  final String name;
  final String detail;
  final String urlImage;
  ProductsModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.urlImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'detail': detail,
      'urlImage': urlImage,
    };
  }

  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      id: (map['id'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      detail: (map['detail'] ?? '') as String,
      urlImage: (map['urlImage'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductsModel.fromJson(String source) => ProductsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
