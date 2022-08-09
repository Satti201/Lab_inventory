
class DeviceTypeModel{
  final int deviceTypeId;
  late String deviceType;

  static const tblDeviceType='DeviceType';
  static const colDeviceTypeId='device_type_id';
  static const colDeviceType= 'device_type';
  DeviceTypeModel({required this.deviceTypeId, required this.deviceType});

  factory DeviceTypeModel.fromJson(Map<String, dynamic> json) {
    return DeviceTypeModel(
      deviceTypeId: json[colDeviceTypeId],
      deviceType: json[colDeviceType],
    );
  }

  Map<String, dynamic> toLocationCategoryMap() {
    var map = <String, dynamic>{colDeviceTypeId: deviceTypeId,colDeviceType: deviceType};
    return map;
  }




}