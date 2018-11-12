# MyWeather
MyWeather with Swift


## Swift Weather APP
 
[课程地址](https://www.imooc.com/learn/149)

林永坚Jake
其它 难度中级 时长 1小时22分 学习人数35617 综合评分9.5 收藏   


简介：本课程将带领大家使用Swift语言开发一个完整的天气 iOS APP。同时大家能够学习到Interface Builder、CocoaPods、Core Location、AFNetworking的使用，以及如何通过Swift调用Objective-C组件，如何通过IBOutlets更新View。

### 第1章 课程概况
课程概况
- 1-1 Swift Weather APP课程概况 (05:19)

### 第2章 新建Swift APP
本章主要是新建一个Swift APP
- 2-1 新建Swift APP (05:46)

### 第3章 使用Interface Builder快速构建原型
本章是通过Interface Builder快速的构建原型
- 3-1 使用Interface Builder快速构建原型 (07:26)

### 第4章 使用CocoaPods
本章使用CocoaPods导入第三方的框架
- 4-1 使用CocoaPods (04:43)

### 第5章 使用Core Location
本章使用Core Location进行定位
- 5-1 使用Core Location (15:05)

### 第6章 使用AFNetworking (完成时间 20181112)
本章使用AFNetworking发送数据请求
- 6-1 使用AFNetworking (10:15)

API要先注册，然后获取APPID：[API Keys地址](https://home.openweathermap.org/api_keys)

用PostMan测试下面的地址
```
http://api.openweathermap.org/data/2.5/weather?lat=30.480718452305457&lon=114.4017477818732&cnt=0&APPID=15f8d9e4177673f65179362e732d65bf
```

核心代码：
```swift
func updateWeatherInfo(latitude:CLLocationDegrees, longitude:CLLocationDegrees) {
    let manager = AFHTTPRequestOperationManager()
    let url = "http://api.openweathermap.org/data/2.5/weather";
    //let url = "http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=15f8d9e4177673f65179362e732d65bf"
    
    let params = ["lat": latitude, "lon":longitude, "cnt":0, "APPID":"15f8d9e4177673f65179362e732d65bf"] as Any
    manager.get(url,
                parameters: params,
                success: { (operation: AFHTTPRequestOperation,
                    responseObject: Any) in
                    var info = responseObject as? NSDictionary
                    print(info);
                    print("OK")
                    
                   // self.updateUISuccess(responseObject as NSDictionary!)
    },
                failure: { (operation: AFHTTPRequestOperation!,
                    error: Error!) in
                    print("Error: " + error.localizedDescription)
                    
                   // self.loading.text = "Internet appears down!"
    })
    
}
```

打印JSON：
```swift
Optional({
    base = stations;
    clouds =     {
        all = 92;
    };
    cod = 200;
    coord =     {
        lat = "30.48";
        lon = "114.4";
    };
    dt = 1541988000;
    id = 7905231;
    main =     {
        humidity = 76;
        pressure = 1023;
        temp = "287.15";
        "temp_max" = "287.15";
        "temp_min" = "287.15";
    };
    name = Guanshan;
    sys =     {
        country = CN;
        id = 7423;
        message = "0.201";
        sunrise = 1541976327;
        sunset = 1542014830;
        type = 1;
    };
    visibility = 2500;
    weather =     (
                {
            description = mist;
            icon = 50d;
            id = 701;
            main = Mist;
        }
    );
    wind =     {
        deg = 30;
        speed = 4;
    };
})
OK
Optional({
    base = stations;
    clouds =     {
        all = 92;
    };
    cod = 200;
    coord =     {
        lat = "30.48";
        lon = "114.4";
    };
    dt = 1541988000;
    id = 7905231;
    main =     {
        humidity = 76;
        pressure = 1023;
        temp = "287.15";
        "temp_max" = "287.15";
        "temp_min" = "287.15";
    };
    name = Guanshan;
    sys =     {
        country = CN;
        id = 7423;
        message = "0.201";
        sunrise = 1541976327;
        sunset = 1542014830;
        type = 1;
    };
    visibility = 2500;
    weather =     (
                {
            description = mist;
            icon = 50d;
            id = 701;
            main = Mist;
        }
    );
    wind =     {
        deg = 30;
        speed = 4;
    };
})
```


### 第7章 通过IBOutlets更新View
本章通过IBOutlets更新View
- 7-1 通过IBOutlets更新View (23:08)

### 第8章 美化我们的APP
本章是对我们的APP进行一个美化，让我们的界面更加优美
- 8-1 美化我们的APP (09:25)


![](https://github.com/CoderDream/MyWeather/blob/master/snapshot/w01.png)

<p align="center">
    <img src="https://github.com/CoderDream/MyWeather/blob/master/snapshot/w01.png" alt="Sample"  width="360" height="640">
    <p align="center">
        <em>图片示例2</em>
    </p>
</p>
--------------------- 
作者：lovechris00 
来源：CSDN 
原文：https://blog.csdn.net/lovechris00/article/details/82379382 
版权声明：本文为博主原创文章，转载请附上博文链接！

课程须知
- 1、具有C#、Javascript、Ruby等语言开发经验的iOS初学者；
- 2、具有Objective-C开发经验的iOS开发者。

老师告诉你能学到什么？
- 1、如何新建Swift APP;
- 2、Interface Builder、CocoaPods、Core Location、AFNetworking的使用；
- 3、如何通过Swift调用Objective-C组件；
- 4、如何通过IBOutlets更新View.