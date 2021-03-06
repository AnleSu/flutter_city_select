/*根据筛选项 自定义model
* 筛选页面可以默认传入一个model 用来做初始被选中的筛选项
* */

enum OPZTaskQueryType {
  OPZTaskQueryTypeAll, // !< 全部
  OPZTaskQueryTypeMy // !< 我的
}

enum OPZTaskStatus {
  OPZTaskStatusAll, // !< 全部
  OPZTaskStatusWaitingDispatch, // !< 待派发
  OPZTaskStatusWaitingHandle, // !< 待处理
  OPZTaskStatusHandling, // !< 处理中
  OPZTaskStatusFinished, // !< 已完成
  OPZTaskStatusCanceled, // !< 已取消
  OPZTaskStatusStoped, // !< 已终止
}

enum OPZTaskType {
  OPZTaskTypeAll, // !< 全部
  OPZTaskTypeWash, // !< 洗车单
  OPZTaskTypeFuel, // !< 加油单
  OPZTaskTypeVehicleValid, // !< 验车单
  OPZTaskTypeScheduling, // !< 调度单
  OPZTaskTypeeVehicleValidDoubt, // !< 取车有疑义
  OPZTaskTypeVehicleValidRefuse, // !< 取车不通过
  OPZTaskTypeUserReportException, // !< 用户上报异常
  OPZTaskTypeDropOffDeveiceException, // !< 还车设备异常
}

enum OPZTaskSource {
  OPZTaskSourceAll, // !< 全部
  OPZTaskSourceOrder, // !< 订单
  OPZTaskSourceManual, // !< 人工
}

class FilterModel {
  /*开始创建时间（yyyy-MM-dd）*/
  String createTimeBegin;

  /*结束创建时间（yyyy-MM-dd）*/
  String createTimeEnd;

  /*查询类型*/
  OPZTaskQueryType queryType;

  /*工单类型，选择全部则无需传：1.洗车单，2-加油单，3-验车单，4-调度单，5-取车有疑义，6-取车不通过，7-用户上报异常，8-还车设备异常*/
  List<OPZTaskType> taskType;

  /*工单来源，选择全部则无需传：1-订单，2-人工*/
  List<OPZTaskSource> taskSrc;

  /*工单状态：1-待派发，2-待处理，3-处理中，4-已完成，5-已取消，6-已终止*/
  OPZTaskStatus taskStatus;

  FilterModel(
      {this.createTimeBegin,
      this.createTimeEnd,
      this.queryType,
      this.taskSrc,
      this.taskStatus,
      this.taskType});

  FilterModel.fromJson(Map<String, dynamic> json) {
    createTimeBegin = json['createTimeBegin'];
    createTimeEnd = json['createTimeEnd'];
    queryType = json['queryType'];
    taskSrc = json['taskSrc'];
    taskStatus = json['taskStatus'];
    taskType = json['taskType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTimeBegin'] = this.createTimeBegin;
    data['createTimeEnd'] = this.createTimeEnd;
    data['queryType'] = this.queryType;
    data['taskSrc'] = this.taskSrc;
    data['taskStatus'] = this.taskStatus;
    data['taskType'] = this.taskType;
    return data;
  }
}

class TaskTypeItemModel {
  OPZTaskType type;
  String typeString;

//  TaskTypeItemModel({this.type, this.typeString});

  TaskTypeItemModel.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    typeString = json['typeString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['typeString'] = this.typeString;

    return data;
  }

  TaskTypeItemModel(OPZTaskType newType) {
    type = newType;
    typeString = _getStringFromType(newType);
  }

  String _getStringFromType(OPZTaskType type) {
    String _typeString;
    switch (type) {
      case OPZTaskType.OPZTaskTypeAll:
        {
          _typeString = '全部';
        }
        break;
      case OPZTaskType.OPZTaskTypeWash:
        {
          _typeString = '洗车';
        }
        break;
      case OPZTaskType.OPZTaskTypeFuel:
        {
          _typeString = '加油';
        }
        break;
      case OPZTaskType.OPZTaskTypeVehicleValid:
        {
          _typeString = '验车';
        }
        break;
      case OPZTaskType.OPZTaskTypeScheduling:
        {
          _typeString = '调度';
        }
        break;
      case OPZTaskType.OPZTaskTypeeVehicleValidDoubt:
        {
          _typeString = '验车有疑义';
        }
        break;
      case OPZTaskType.OPZTaskTypeVehicleValidRefuse:
        {
          _typeString = '验车不通过';
        }
        break;
      case OPZTaskType.OPZTaskTypeUserReportException:
        {
          _typeString = '用户上报故障';
        }
        break;
      case OPZTaskType.OPZTaskTypeDropOffDeveiceException:
        {
          _typeString = '还车设备异常';
        }
        break;
      default:
        {}
        break;
    }
    return _typeString;
  }
}


class TaskSourceItemModel {
  OPZTaskSource type;
  String typeString;


  TaskSourceItemModel.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    typeString = json['typeString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['typeString'] = this.typeString;

    return data;
  }

  TaskSourceItemModel(OPZTaskSource newType) {
    type = newType;
    typeString = _getStringFromType(newType);
  }

  String _getStringFromType(OPZTaskSource type) {
    String _typeString;
    switch (type) {
      case OPZTaskSource.OPZTaskSourceAll:
        {
          _typeString = '全部';
        }
        break;
      case OPZTaskSource.OPZTaskSourceManual:
        {
          _typeString = '人工';
        }
        break;
      case OPZTaskSource.OPZTaskSourceOrder:
        {
          _typeString = '订单';
        }
        break;

      default:
        {}
        break;
    }
    return _typeString;
  }
}
