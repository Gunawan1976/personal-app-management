class ProfileEntities {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? maidenName;
  final int? age;
  final String? gender;
  final String? email;
  final String? phone;
  final String? username;
  final String? password;
  final String? birthDate;
  final String? image;
  final String? bloodGroup;
  final double? height;
  final double? weight;
  final String? eyeColor;
  final HairEntities? hair;
  final String? ip;
  final AddressEntities? address;
  final String? macAddress;
  final String? university;
  final BankEntities? bank;
  final CompanyEntities? company;
  final String? ein;
  final String? ssn;
  final String? userAgent;
  final CryptoEntities? crypto;
  final String? role;

  ProfileEntities({
    this.id,
    this.firstName,
    this.lastName,
    this.maidenName,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.username,
    this.password,
    this.birthDate,
    this.image,
    this.bloodGroup,
    this.height,
    this.weight,
    this.eyeColor,
    this.hair,
    this.ip,
    this.address,
    this.macAddress,
    this.university,
    this.bank,
    this.company,
    this.ein,
    this.ssn,
    this.userAgent,
    this.crypto,
    this.role,
  });

}

class AddressEntities {
  final String? address;
  final String? city;
  final String? state;
  final String? stateCode;
  final String? postalCode;
  final CoordinatesEntities? coordinates;
  final String? country;

  AddressEntities({
    this.address,
    this.city,
    this.state,
    this.stateCode,
    this.postalCode,
    this.coordinates,
    this.country,
  });

}

class CoordinatesEntities {
  final double? lat;
  final double? lng;

  CoordinatesEntities({
    this.lat,
    this.lng,
  });

}

class BankEntities {
  final String? cardExpire;
  final String? cardNumber;
  final String? cardType;
  final String? currency;
  final String? iban;

  BankEntities({
    this.cardExpire,
    this.cardNumber,
    this.cardType,
    this.currency,
    this.iban,
  });

}

class CompanyEntities {
  final String? department;
  final String? name;
  final String? title;
  final AddressEntities? address;

  CompanyEntities({
    this.department,
    this.name,
    this.title,
    this.address,
  });

}

class CryptoEntities {
  final String? coin;
  final String? wallet;
  final String? network;

  CryptoEntities({
    this.coin,
    this.wallet,
    this.network,
  });

}

class HairEntities {
  final String? color;
  final String? type;

  HairEntities({
    this.color,
    this.type,
  });

}
