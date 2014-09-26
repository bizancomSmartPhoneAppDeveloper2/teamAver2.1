//
//  SecondViewController.m
//  KOKOIKE
//
//  Created by ビザンコムマック０７ on 2014/09/25.
//  Copyright (c) 2014年 mycompany. All rights reserved.
/*ロケタッチのAPI
 {"name_kana":"さんまるくかふぇゆめたうんとくしまてん","photo":null,"date":{"created":"2014-09-12","modified":"2014-09-12"},"item_id":"550816","alphabet":"ST-MARC CAFE","north_latitude":"34.119264","tel":"088-693-3097","url":"http://www.saint-marc-hd.com/cafe/","category":{"name":"カフェ","id":"601"},"address":"板野郡藍住町奥野字東中須88-1 ゆめタウン徳島 2F","property":"ゆめタウン徳島店","holiday":"10:00 - 22:00","mobile_permalink":"http://gourmet.m.livedoor.com/restaurant/550816/","count":{"fan":"0","special":"0","comment":"0","photo":"0","access":"6","menu":"0","evaluation":"0"},"pref":{"name":"徳島県","id":"36"},"name":"サンマルクカフェ","description":null,"openhours_note":null,"open":{"morning":"なし","late":"なし","lunch":"あり"},"zip":null,"livedoor_id":"sikisai4","area":{"name":"徳島市","id":"1701"},"trackback":"http://gourmet.livedoor.com/trackback/550816/","purpose":"友人・同僚と,一人ご飯","permalink":"http://gourmet.livedoor.com/restaurant/550816/","fax":null,"east_longitude":"134.501139","closed":"","price_range":{"lunch":"1,000円以下","dinner":"1,000円以下"},"weekday":"10:00 - 22:00","hotpepper_coupon":"なし","station":{"distance":"3289","time":"41","name":"吉成","id":"7305"},"closeday":{"days":"年中無休","note":null},"average":{"cost_performance":"0.0","food":"0.0","atmosphere":"0.0","total":"0.0","service":"0.0"},"saturday":"10:00 - 22:00"}
 
 yahooの緯度と経度の距離のapi
 データ
 URLhttp://distance.search.olp.yahooapis.jp/OpenLocalPlatform/V1/distance?appid=dj0zaiZpPUdJZWUzd25yTGV5ZCZzPWNvbnN1bWVyc2VjcmV0Jng9MTE-&coordinates=134.550753,34.074594 134.554911,34.070337&output=json
 距離の出し方(JSONデータの場合)
 [[[[dic1 objectForKey:@"Feature"] objectAtIndex:0] objectForKey:@"Geometry"] objectForKey:@"Distance"]
 
 
*/
#import "SecondViewController.h"

@interface SecondViewController ()<NSXMLParserDelegate>{
    //昼飯の店舗の探すAPIのURLの文字列を格納するための変数
    NSString *resurlstr;
    //緯度と経度で距離を導くAPIのURLの文字列を格納するための変数
    NSString *disurlstr;
    //経度と経度で距離を導くAPIのURLを生成するための変数
    NSURL *disurl;
    //昼飯の店舗の探すAPIのURLを生成するための変数
    NSURL *resurl;
    //周辺の町を探すAPIのURLを生成するための変数
    NSString *townstrurl;
    
    NSURL *townurl;
    NSXMLParser *p;
}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    resurlstr = @"http://api.gourmet.livedoor.com/v1.0/restaurant/?api_key=5749e32d289c9781579eddb4aff08d92953d6638&address=徳島県鳴門市大麻町&type=json";
    disurlstr = @"http://distance.search.olp.yahooapis.jp/OpenLocalPlatform/V1/distance?appid=dj0zaiZpPUdJZWUzd25yTGV5ZCZzPWNvbnN1bWVyc2VjcmV0Jng9MTE-&output=xml&coordinates=134.550753,34.0745945%20134.554911,34.070337";
    townstrurl = @"http://geoapi.heartrails.com/api/json?method=searchByGeoLocation&x=135.0&y=35.0";
    
    resurl = [NSURL URLWithString:resurlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:resurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSHTTPURLResponse *response;
    NSError *err = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSLog(@"%@",err.localizedDescription);
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    NSLog(@"開始タグ%@",elementName);
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    NSLog(@"中の文字列%@",string);
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
}

@end
