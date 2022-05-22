import 'dart:typed_data';

import 'package:admin_shop/src/db/auth.dart';
import 'package:admin_shop/src/db/storage.dart';
import 'package:admin_shop/src/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProductRepository {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('products');
  final auth = AuthService();
  final storage = StorageRepo();

  Future<void> addProduct(
      String title,
      String description,
      String price,
      String category,
      String quantity,
      String brand,
      List<Uint8List> images,
      String remise) async {
    final id = const Uuid().v1();
    final userId = await auth.getCurrentUserUid();
    List<String> imagesUrl = [];
    for (var image in images) {
      final url = await storage.uploadProductFile(image);
      imagesUrl.add(url!);
    }
    Product product = Product(
        id: id,
        title: title,
        description: description,
        price: double.parse(price),
        images: imagesUrl,
        userId: userId!,
        quantity: int.parse(quantity),
        category: category,
        brand: brand,
        remise: double.parse(remise),
        ratings: [],
        reviews: [],
        flashSales: false,
        newProduct: false,
        bestSeller: false,
        popular: false,
        blackMarket: false,
        summerSales: false);
    await _collectionReference.doc(id).set(product.toJson());
  }

  Stream<List<Product>> getProducts() {
    return _collectionReference.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //get popular products
  Stream<List<Product>> getPopularProducts() {
    return _collectionReference
        .where('popular', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //get flash sales products
  Stream<List<Product>> getFlashSalesProducts() {
    return _collectionReference
        .where('flashSales', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //get new products
  Stream<List<Product>> getNewProducts() {
    return _collectionReference
        .where('newProduct', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //get best seller products
  Stream<List<Product>> getBestSellerProducts() {
    return _collectionReference
        .where('bestSeller', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //get black market products
  Stream<List<Product>> getBlackMarketProducts() {
    return _collectionReference
        .where('blackMarket', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  //get summer sales products
  Stream<List<Product>> getSummerSalesProducts() {
    return _collectionReference
        .where('summerSales', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _collectionReference.doc(product.id).update(product.toJson());
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _collectionReference.doc(id).delete();
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Future<void> addProductToPopular(Product product) async {
    try {
      await _collectionReference.doc(product.id).update({
        'popular': true,
      });
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Future<void> removeProductFromPopular(Product product) async {
    try {
      await _collectionReference.doc(product.id).update({
        'popular': false,
      });
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Future<void> addProductToNew(Product product) async {
    try {
      await _collectionReference.doc(product.id).update({
        'newProduct': true,
      });
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Future<void> removeProductFromNew(Product product) async {
    try {
      await _collectionReference.doc(product.id).update({
        'newProduct': false,
      });
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Future<void> addProductToBestSeller(Product product) async {
    try {
      await _collectionReference.doc(product.id).update({
        'bestSeller': true,
      });
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Future<void> removeProductFromBestSeller(Product product) async {
    try {
      await _collectionReference.doc(product.id).update({
        'bestSeller': false,
      });
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Future<void> addProductToBlackMarket(Product product) async {
    try {
      await _collectionReference.doc(product.id).update({
        'blackMarket': true,
      });
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Future<void> removeProductFromBlackMarket(Product product) async {
    try {
      await _collectionReference.doc(product.id).update({
        'blackMarket': false,
      });
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Future<void> addProductToSummerSales(Product product) async {
    try {
      await _collectionReference.doc(product.id).update({
        'summerSales': true,
      });
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Future<void> removeProductFromSummerSales(Product product) async {
    try {
      await _collectionReference.doc(product.id).update({
        'summerSales': false,
      });
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Future<void> addProductToFlashSales(Product product) async {
    try {
      await _collectionReference.doc(product.id).update({
        'flashSales': true,
      });
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }

  Future<void> removeProductFromFlashSales(Product product) async {
    try {
      await _collectionReference.doc(product.id).update({
        'flashSales': false,
      });
    } catch (e) {
      debugPrint('error ' + e.toString());
    }
  }
}
