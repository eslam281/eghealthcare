class XrayAnalysisModel {
  String? inferenceId;
  double? time;
  ImageInfoModel? image;
  List<Predictions>? predictions;
  String? top;
  double? confidence;

  XrayAnalysisModel({this.inferenceId, this.time, this.image, this.predictions, this.top, this.confidence});

  XrayAnalysisModel.fromJson(Map<String, dynamic> json) {
    inferenceId = json['inference_id'];
    time = json['time'];
    image = json['image'] != null ? ImageInfoModel.fromJson(json['image']) : null;
    if (json['predictions'] != null) {
      predictions = (json['predictions'] as List)
          .map((e) => Predictions.fromJson(e)).toList();
    }

    top = json['top'];
    confidence = json['confidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inference_id'] = inferenceId;
    data['time'] = time;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    if (predictions != null) {
      data['predictions'] = predictions!.map((v) => v.toJson()).toList();
    }
    data['top'] = top;
    data['confidence'] = confidence;
    return data;
  }
}

class ImageInfoModel {
  int? width;
  int? height;

  ImageInfoModel({this.width, this.height});

  ImageInfoModel.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}

class Predictions {
  double? x;
  double? y;
  int? width;
  int? height;
  double? confidence;
  String? kind;
  int? classId;
  String? detectionId;

  Predictions({this.x, this.y, this.width, this.height, this.confidence, this.kind, this.classId, this.detectionId});

  Predictions.fromJson(Map<String, dynamic> json) {
  x = json['x'];
  y = json['y'];
  width = json['width'];
  height = json['height'];
  confidence = json['confidence'];
  kind = json['class'];
  classId = json['class_id'];
  detectionId = json['detection_id'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['x'] = x;
  data['y'] = y;
  data['width'] = width;
  data['height'] = height;
  data['confidence'] = confidence;
  data['class'] = kind;
  data['class_id'] = classId;
  data['detection_id'] = detectionId;
  return data;
  }
}
