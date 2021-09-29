import 'package:flutter/material.dart';

class AccesMenu {
  final String image, title, description;
  final int price, size, id;
  final Color color;
  AccesMenu({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.size,
    required this.color,
  });
}

List<AccesMenu> accesMenu = [
  AccesMenu(
      id: 1,
      title: "Office Code",
      price: 234,
      size: 12,
      description: "dummyText",
      image: "assets/images/dark/calendario.png",
      color: Colors.white30), //Color(0xFF3D82AE)),
  AccesMenu(
      id: 2,
      title: "Belt Bag",
      price: 234,
      size: 8,
      description: "dummyText",
      image: "assets/images/dark/averia1.jpg",
      color: Colors.white30), //Color(0xFFD3A984)),
  AccesMenu(
      id: 3,
      title: "Hang Top",
      price: 234,
      size: 10,
      description: "dummyText",
      image: "assets/images/dark/telefonopublico.jpg",
      color: Colors.white30), //Color(0xFF989493)),
  AccesMenu(
      id: 4,
      title: "Old Fashion",
      price: 234,
      size: 11,
      description: "dummyTe",
      image: "assets/images/dark/gps.png",
      color: Colors.white30), //Color(0xFFE6B398)),
  AccesMenu(
      id: 5,
      title: "Office Code",
      price: 234,
      size: 12,
      description: "dummyText",
      image: "assets/images/bag_5.png",
      color: Color(0xFFFB7883)),
  AccesMenu(
    id: 6,
    title: "Office Code",
    price: 234,
    size: 12,
    description: "dummyText",
    image: "assets/images/bag_6.png",
    color: Color(0xFFAEAEAE),
  ),
];
