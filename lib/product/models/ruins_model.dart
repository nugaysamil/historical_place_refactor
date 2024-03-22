import 'dart:convert';

class RuinsModel {
  final int? id;
  final String? name;
  final String? slug;
  final double? latitude;
  final double? longitude;
  final String? information;
  final String? image;
  final String? tripadvisor;
  final String? foursquare;
  final int? officialSite;
  final String? officialSiteLink;
  final int? cityId;
  final List<IshLink>? turkishLinks;
  final List<IshLink>? englishLinks;

  RuinsModel({
    this.id,
    this.name,
    this.slug,
    this.latitude,
    this.longitude,
    this.information,
    this.image,
    this.tripadvisor,
    this.foursquare,
    this.officialSite,
    this.officialSiteLink,
    this.cityId,
    this.turkishLinks,
    this.englishLinks,
  });

  factory RuinsModel.fromRawJson(String str) =>
      RuinsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RuinsModel.fromJson(Map<String, dynamic> json) => RuinsModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        information: json["information"],
        image: json["image"],
        tripadvisor: json["tripadvisor"],
        foursquare: json["foursquare"],
        officialSite: json["official_site"],
        officialSiteLink: json["official_site_link"],
        cityId: json["city_id"],
        turkishLinks: json["turkish_links"] == null
            ? []
            : List<IshLink>.from(
                json["turkish_links"]!.map((x) => IshLink.fromJson(x))),
        englishLinks: json["english_links"] == null
            ? []
            : List<IshLink>.from(
                json["english_links"]!.map((x) => IshLink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "latitude": latitude,
        "longitude": longitude,
        "information": information,
        "image": image,
        "tripadvisor": tripadvisor,
        "foursquare": foursquare,
        "official_site": officialSite,
        "official_site_link": officialSiteLink,
        "city_id": cityId,
        "turkish_links": turkishLinks == null
            ? []
            : List<dynamic>.from(turkishLinks!.map((x) => x.toJson())),
        "english_links": englishLinks == null
            ? []
            : List<dynamic>.from(englishLinks!.map((x) => x.toJson())),
      };
}

class IshLink {
  final String? description;
  final String? url;
  final String? language;

  IshLink({
    this.description,
    this.url,
    this.language,
  });

  factory IshLink.fromRawJson(String str) => IshLink.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IshLink.fromJson(Map<String, dynamic> json) => IshLink(
        description: json["description"],
        url: json["url"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "url": url,
        "language": language,
      };
}
