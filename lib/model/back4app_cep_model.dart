class Back4appCepModel {
  List<Cep> ceps = [];

  Back4appCepModel();

  Back4appCepModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      ceps = <Cep>[];
      json['results'].forEach((v) {
        ceps.add(Cep.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['results'] = ceps.map((v) => v.toJson()).toList();

    return data;
  }
}

class Cep {
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String? cep;

  Cep({this.objectId, this.createdAt, this.updatedAt, this.cep});
  Cep.simple(this.cep);

  Cep.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    cep = json['cep'];
  }

  Map<String, dynamic> toSimple() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['cep'] = cep;
    return data;
  }
}
