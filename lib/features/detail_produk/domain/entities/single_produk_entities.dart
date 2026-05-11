import 'package:equatable/equatable.dart';

class SingleProductEntities extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final List<String>? tags;
  final String? brand;
  final String? sku;
  final int? weight;
  final DimensionsEntities? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<ReviewEntities>? reviews;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final MetaEntities? meta;
  final String? thumbnail;
  final List<String>? images;

  SingleProductEntities({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.thumbnail,
    this.images,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    price,
    discountPercentage,
    rating,
    stock,
    tags,
    brand,
    sku,
    weight,
    dimensions,
    warrantyInformation,
    shippingInformation,
    availabilityStatus,
    reviews,
    returnPolicy,
    minimumOrderQuantity,
    meta,
    thumbnail,
    images,
  ];
}

class DimensionsEntities extends Equatable{
  final double? width;
  final double? height;
  final double? depth;

  DimensionsEntities({
    this.width,
    this.height,
    this.depth,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [width, height, depth];


}

class MetaEntities extends Equatable{
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? barcode;
  final String? qrCode;

  MetaEntities({
    this.createdAt,
    this.updatedAt,
    this.barcode,
    this.qrCode,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [createdAt, updatedAt, barcode, qrCode];


}

class ReviewEntities extends Equatable{
  final int? rating;
  final String? comment;
  final DateTime? date;
  final String? reviewerName;
  final String? reviewerEmail;

  ReviewEntities({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    rating,
    comment,
    date,
    reviewerName,
    reviewerEmail,
  ];


}
