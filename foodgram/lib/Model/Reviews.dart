import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Reviews {
  final String name;
  final String rating;
  final String date;
  final String comment;
  final String avatar;
  final Color avatarColor;

  Reviews({
    required this.name,
    required this.rating,
    required this.date,
    required this.comment,
    required this.avatar,
    required this.avatarColor,
  });

  // Convertir objeto a Map (para guardar en Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rating': rating,
      'date': date,
      'comment': comment,
      'avatar': avatar,
      'avatarColor': avatarColor.value, // guardamos el int del color
    };
  }

  // Crear objeto desde Map (cuando leemos de Firestore)
factory Reviews.fromMap(Map<String, dynamic> map) {
  return Reviews(
    name: map['name'] ?? '',
    rating: map['rating']?.toString() ?? '', // Lo forzamos a String por si viene como número
    date: map['date'] ?? '',
    comment: map['comment'] ?? '',
    avatar: map['avatar'] ?? '',
    // Lógica para convertir el String del JSON a un Color real
    avatarColor: _parseColor(map['avatarColor']),
  );
}

// Función auxiliar para entender "red", "blue", etc.
static Color _parseColor(dynamic colorData) {
  if (colorData is int) return Color(colorData);
  
  switch (colorData.toString().toLowerCase()) {
    case 'red': return Colors.red;
    case 'blue': return Colors.blue;
    case 'orange': return Colors.orange;
    case 'green': return Colors.green;
    default: return Colors.black; // Color por defecto
  }
}
  // Crear objeto directamente desde DocumentSnapshot
  factory Reviews.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Reviews.fromMap(data);
  }
}