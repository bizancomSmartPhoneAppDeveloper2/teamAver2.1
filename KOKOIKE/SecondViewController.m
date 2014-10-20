//
//  SecondViewController.m
//  KOKOIKE
//
//  Created by ビザンコムマック０７ on 2014/09/25.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//初期画面のボタンを押したときに遷移される画面の管理クラス

#import "SecondViewController.h"
#import "Anotetion.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SecondViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>{
    //GPSを起動するための変数
    CLLocationManager *manager;
    //起動したときの緯度と経度を格納するための変数
    CLLocationCoordinate2D nowlocation;
    //レストランの緯度と経度を格納するための変数
    CLLocationCoordinate2D reslocation;
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
    //周辺の町を探すAPIのURLを生成するための変数
    NSURL *townurl;
    //町の情報を格納した配列を格納するための変数
    //配列の型{県から町の名前、経度、緯度}
    NSMutableArray *townarray;
    //指定する距離の長さ(km)を格納する変数
    float choicedis;
    //レストランの情報を格納する配列の変数
    //配列の型{レストランの名前、経度、緯度}
    NSMutableArray *resarray;
    //画面遷移したときにsetupメソッドを呼ぶために使われる変数
    BOOL start;
    //アノテーションの変数
    Anotetion *anotetion;
    //制限時間の分を表す変数
    int minute;
    //制限時間の秒を表す変数
    int seconds;
    //吹き出しの台詞を変えるために使うカウント変数
    int count;
    NSTimer *timer;
}

//音源用のプロパティを準備
@property AVAudioPlayer *voice;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    self.fukidashi.text = @"まあ待て";
    start = YES;
    choicedis = 0.8;
    //timelabelを非表示
    self.timelabel.hidden = YES;
    //mapを非表示にする
    self.map.hidden = YES;
    //配列を初期化
    townarray = [NSMutableArray array];
    resarray = [NSMutableArray array];
    //managerの初期化
    manager = [[CLLocationManager alloc] init];
    //managerのデリゲートを自分自身に指定
    manager.delegate = self;
    self.map.delegate = self;
    //managerがrequestWhenInUseAuthorizationというメソッドを持っているか
    if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        //requestWhenInUseAuthorizationを実行
        //位置情報の使用をアプリ起動時のみ許可してもらうよう要求
        [manager requestWhenInUseAuthorization];
    }
    //測位の精度を10mに指定する
    manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    //位置情報取得間隔を10mに指定する
    manager.distanceFilter = 10.0;
    //GPSを使用する
    [manager startUpdatingLocation];
    //レストラン情報取得apiのURLの文字列を格納
    resurlstr = @"http://api.gourmet.livedoor.com/v1.0/restaurant/?api_key=5749e32d289c9781579eddb4aff08d92953d6638&type=json&address=";
     //距離取得apiのURLの文字列を格納
    disurlstr = @"http://distance.search.olp.yahooapis.jp/OpenLocalPlatform/V1/distance?appid=dj0zaiZpPUdJZWUzd25yTGV5ZCZzPWNvbnN1bWVyc2VjcmV0Jng9MTE-&output=json&coordinates=(fromx),(fromy)%20(tox),(toy)";
    //町の周辺情報取得apiのURLの文字列を格納
    townstrurl = @"http://geoapi.heartrails.com/api/json?method=searchByGeoLocation&";
    
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

//位置情報を取るたびによばれるメソッド
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //最近の位置情報を取得
    CLLocation *location = [locations lastObject];
    //startがYESであるか
    if (start) {
        //最近の緯度を取得
        nowlocation.latitude = location.coordinate.latitude;
        //最近の経度を取得
        nowlocation.longitude = location.coordinate.longitude;
        //setupメソッドを呼ぶ
        [self setup];
        start = NO;
    }
    //レストランの緯度と経度がともに0度でないか
    if ((reslocation.latitude != 0) && (reslocation.longitude != 0)) {
        //レストランと現在の位置情報を表す変数
        CLLocation *from = [[CLLocation alloc] initWithLatitude:nowlocation.latitude longitude:nowlocation.longitude];
        CLLocation *to = [[CLLocation alloc] initWithLatitude:reslocation.latitude longitude:reslocation.longitude];
        //レストランと現在位置の距離が10m以内か
        if ([from distanceFromLocation:to] < 10) {
            //タイマーをとめる
            [timer invalidate];
            timer = nil;
            //成功画面に移る
            [self performSegueWithIdentifier:@"sucesssegue" sender:self];
        }
    }
}

//緯度と経度からの町の周辺の情報の配列を返すためのメソッド
//返ってくる配列の型
//{{県から町の名前,経度,緯度},{県から町の名前,経度,緯度},....}
//引数x(経度を表す文字列) y(緯度を表す文字列)
-(NSArray*)arraytown:(NSString*)x latitude:(NSString*)y{
    //返すための配列の変数を生成
    NSMutableArray *returnarray = [NSMutableArray array];
    //経度と緯度の情報の文字列を生成
    NSString *loactionstr = [NSString stringWithFormat:@"x=%@&y=%@",x,y];
    //townstrurlの右にlocationstrを足した文字列を生成
    NSString *townstr = [townstrurl stringByAppendingString:loactionstr];
    //文字列townurlのURLのJSONオブジェクトを格納
    NSDictionary *dic = [self JSONData:townstr];
    //町の情報に関する辞書が格納された配列(dicのresponseの要素のlocationの要素)を格納
    NSArray *tmparray = [[dic objectForKey:@"response"] objectForKey:@"location"];
        //townarrayの初期化の処理
        for (int i = 0; i < [tmparray count]; i++) {
            //町の情報に関する辞書(tmparrayの要素)を格納
            NSDictionary *dic = [tmparray objectAtIndex:i];
            //県から町までの名前の文字列を生成
            //dicのprefectureの要素が県の名前、cityの要素が市の名前、townの要素が町の名前でありそれら結合している
            NSString *town = [[[dic objectForKey:@"prefecture"]stringByAppendingString:[dic objectForKey:@"city"]] stringByAppendingString:[dic objectForKey:@"town"]];
            //文字列townから括弧の文字を消す
            town = [town stringByReplacingOccurrencesOfString:@"（" withString:@""];
            town = [town stringByReplacingOccurrencesOfString:@"）" withString:@""];
            //町の情報の配列を生成
            //1番目の要素　県から町の名前
            //2番目の要素　経度
            //3番目の要素　緯度
            NSArray *info = [NSArray arrayWithObjects:town,[dic objectForKey:@"x"],[dic objectForKey:@"y"], nil];
            //returnarrayの末尾にinfoを追加
            [returnarray addObject:info];
        }
    //配列を返す
    return returnarray;
}

//JSONオブジェクト(NSDictionary)のデータが返ってくるメソッド
-(NSDictionary*)JSONData:(NSString*)url{
    //URLを生成
    NSURL *dataurl = [NSURL URLWithString:url];
    //リクエスト生成
    NSURLRequest *request = [NSURLRequest requestWithURL:dataurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //レスポンスを生成
    NSHTTPURLResponse *response;
    //NSErrorの初期化
    NSError *err = nil;
    //requestによって返ってきたデータを生成
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    //dataを元にJSONオブジェクトを生成
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    //値を返す
    return dic;
}


//指定された範囲内の周辺の町情報を取得するためのメソッド
-(void)townchoice{
    //現在の経度の文字列を格納
    NSString *keido = [NSString stringWithFormat:@"%f",nowlocation.longitude];
    //現在の緯度の文字列を格納
    NSString *ido = [NSString stringWithFormat:@"%f",nowlocation.latitude];
    //現在の経度と緯度を用いて町の周辺情報を格納
    //データ型{{町の名前、経度、緯度},{町の名前、経度、緯度},....,{町の名前、経度、緯度}}
    NSArray *firstarray = [self arraytown:keido latitude:ido];
    //firstarrayの要素の数の繰り返しの処理を行う
    for (int i = 0; i < [firstarray count]; i++) {
        //firstarrayのi番目の要素を格納
        NSArray *choicearray = [firstarray objectAtIndex:i];
            [townarray addObject:choicearray];
            
            NSLog(@"町追加");
    }

}

//町の情報をもとにレストランの情報を取得するためのメソッド
-(void)reschoice{
    //townarrayの要素の数の繰り返しの処理を行う
    for (int i = 0; i < [townarray count]; i++) {
        //町の名前を格納
        NSString *address = [[townarray objectAtIndex:i] objectAtIndex:0];
        //町の名前をエンコード
        NSString *encode = [address stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
        //apiのURLとエンコードした文字列を組み合わせ
        NSString *addurl = [resurlstr stringByAppendingString:encode];
        //addurlを元にJSONオブジェクト生成
        NSDictionary *dic = [self JSONData:addurl];
        //検索結果があるかどうか
        if ([[dic objectForKey:@"total_entries"] length] > 0) {
            NSLog(@"レストラン検索あり");
            //検索結果の数を格納
            int total = [[dic objectForKey:@"total_entries"] intValue];
            //結果で表示される最後のページ数の変数を生成
            int page = total /10;
            if (total % 10 > 0) {
                page += 1;
            }
            //pageの数の繰り返し処理を行う
            for (int k = 1; k <= page; k++) {
                NSLog(@"%dページ目の処理",k);
                //k番目のページのレストランの情報を取得するためのURLの文字列を生成
                NSString *pageurl = [addurl stringByAppendingString:[NSString stringWithFormat:@"&page=%d",k]];
                //pageurlのJSONオブジェクトを格納
                NSDictionary *resdic = [self JSONData:pageurl];
                //レストランの情報が格納されている配列を格納
                NSArray *tmparray = [resdic objectForKey:@"results"];
                //tmparrayの要素の数の繰り返し処理を行う
                for (int n = 0; n < [tmparray count]; n++) {
                    //n番目のデータを格納
                    NSDictionary *tmpdic = [tmparray objectAtIndex:n];
                    //店の位置情報を表す変数
                    CLLocation *tmplocation = [[CLLocation alloc]initWithLatitude:[[tmpdic objectForKey:@"north_latitude"] doubleValue] longitude:[[tmpdic objectForKey:@"east_longitude"] doubleValue]];
                    //起動したときの位置情報を表す変数
                    CLLocation *fromlocation = [[CLLocation alloc]initWithLatitude:nowlocation.latitude longitude:nowlocation.longitude];
                    float dis = (float)[tmplocation distanceFromLocation:fromlocation] / 1000;

                    
                    //現在の緯度と経度からレストランの緯度と経度までの距離が指定距離より低いか
                    if (choicedis > dis) {
                        //resarrayに追加する配列を生成
                        NSArray *addarray = [NSArray arrayWithObjects:[tmpdic objectForKey:@"name"],[tmpdic objectForKey:@"east_longitude"],[tmpdic objectForKey:@"north_latitude"], [[tmpdic objectForKey:@"category"] objectForKey:@"name"],[tmpdic objectForKey:@"tel"],nil];

                        //resarrayの末尾にaddarrayを追加
                        NSLog(@"resarrayの要素を追加");
                        [resarray addObject:addarray];
                    }
                }
            }
        }
    }
}

//起動したときに町の周辺情報、レストランの情報を取り、そこからピンを立てるメソッド
-(void)setup{
    //メインキューの初期化
    dispatch_queue_t mainqueue = dispatch_get_main_queue();
    //グローバルキューの初期化
    dispatch_queue_t globalqueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //インジケーターのアニメーション開始
    [self.activity startAnimating];
    dispatch_async(globalqueue, ^{
        NSLog(@"バック処理開始");
        //バックグラウンド処理
        //メソッドtownchoiceとreschoiceを実行
        [self townchoice];
        [self reschoice];
        dispatch_async(mainqueue, ^{
            NSLog(@"メイン処理");
            //メイン処理
            //インジケーターのアニメーション停止
            [self.activity stopAnimating];
            //インジケーターを非表示
            self.activity.hidesWhenStopped = YES;
            //resarrayの要素があるかどうか
            if ([resarray count] > 0) {
                NSLog(@"検索成功");
                //分と秒の初期設定
                minute = 10;
                seconds = 0;
                count = 0;
                //現在地を青丸で表示する
                self.map.showsUserLocation = YES;
                //mapを表示する
                self.map.hidden = NO;
                //timelabelを表示
                //self.label.hidden = NO;
                //メソッドresanotetionを実行
                [self resanotetion];
            }else{
                NSLog(@"検索失敗");
                //GPSを止める
                [manager stopUpdatingLocation];
                //検索失敗画面に移る
                [self performSegueWithIdentifier:@"NotfoundSegue" sender:self];
            }
        });
    });
    
}

//アノテーションを追加してアノテーション(ピン)が表示されるときに呼ばれるメソッド
-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //現在地の情報でないか
    if (annotation != self.map.userLocation) {
        NSString *pin = @"pin";
        //pinで示すリサイクル可能なアノテーションビューかnilが返ってくる
        MKAnnotationView *av = (MKAnnotationView*)[self.map dequeueReusableAnnotationViewWithIdentifier:pin];
        if (av == nil) {
            //anotetionとpinを用いて値を代入
            av = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pin];
            //表示する画像を設定
            av.image = [UIImage imageNamed:@"mappin2.png"];
            //ピンをクリックしたときに情報を表示するようにする
            av.canShowCallout = YES;
        }
        return av;
    }else{
        return nil;
    }
}

//レストランのアノテーション追加するためのメソッド
-(void)resanotetion{
    //resarrayの中にある配列からランダム中質
    NSArray *choicearray = [resarray objectAtIndex:arc4random()%[resarray count]];
    
    //レストランのジャンルの名前を格納
    NSString *janl = [[@"(" stringByAppendingString:[choicearray objectAtIndex:3]] stringByAppendingString:@")"];
        //現在の経度と緯度から指定されたレストランの経度と緯度の距離を格納
    //起動したときの位置情報を表す変数
    CLLocation *fromlocation = [[CLLocation alloc]initWithLatitude:nowlocation.latitude longitude:nowlocation.longitude];
    //レストランの位置情報を表す変数
    CLLocation *tolocation = [[CLLocation alloc]initWithLatitude:[[choicearray objectAtIndex:2] doubleValue] longitude:[[choicearray objectAtIndex:1] doubleValue]];
    //レストランと現在地の距離を表す変数
    float resdis = (float)[tolocation distanceFromLocation:fromlocation] / 1000;
    //経度の文字列(choicearrayの1番目の要素)をdouble型にキャストしたものを格納
    reslocation.longitude = [[choicearray objectAtIndex:1] doubleValue];
    //緯度の文字列(choicearrayの2番目の要素)をdouble型にキャストしたものを格納
    reslocation.latitude = [[choicearray objectAtIndex:2] doubleValue];
    //MKCooredinateRegionの変数の初期化
    MKCoordinateRegion region = self.map.region;
    //マップが表示された時の中心の経度設定
    region.center.longitude = (nowlocation.longitude + reslocation.longitude)/2;
    //マップが表示された時の中心の緯度設定
    region.center.latitude = (nowlocation.latitude + reslocation.latitude)/2;
    //1度を約111.2kmとする
    //現在地から店の距離によってマップの縮尺度を設定
    region.span.latitudeDelta = (resdis + 0.15) / 111.2;
    region.span.longitudeDelta = (resdis + 0.15) / 111.2;
    [self.map setRegion:region];
    //アノテーションを初期化
    anotetion = [[Anotetion alloc] initwithCoordinate:reslocation];
    //アノテーションのタイトルを店の名前にする
    anotetion.title = [[choicearray objectAtIndex:0]stringByAppendingString:janl];
    //アノテーションのサブタイトルを電話番号にする
    anotetion.subtitle = [choicearray objectAtIndex:4];
    //今すぐに(店名)に行けとラベルに表示
    self.label.text = [choicearray objectAtIndex:0];
//    self.label.text = [self.label.text stringByAppendingString:@"に行け"];
    //マップにアノテーションを追加
    [self.map addAnnotation:anotetion];
        
        //timelabelの表示する文字列の設定
        self.timelabel.text = [NSString stringWithFormat:@"%02d:%02d",minute,seconds];
        self.fukidashi.text = @"すぐ行け!";
        //1秒ごとにメソッドcountdownを実行
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    self.timelabel.hidden = NO;
}


//GPSが起動できないときによばれるメソッド
-(void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{
    NSLog(@"GPS起動しません");
    self.label.text = @"GPS起動しません";
}

//カウントダウン用のメソッド
-(void)countdown{
    count++;
    //秒の数が0であるか
    if (seconds == 0) {
        //分の数をデクリメント
        minute--;
        //秒の数を59にする
        seconds = 59;
    }else{
        //秒の数をデクリメント
        seconds--;
    }
    //秒と分の数がともに0であるか
    if ((minute == 0) && (seconds == 0)) {
        //タイマーを止める
        [timer invalidate];
        timer = nil;
        //失敗の画面に移る
        [self performSegueWithIdentifier:@"failsegue" sender:self];
        
        //ガキの使いっぽい音を鳴らす
        NSString *path = [[NSBundle mainBundle]pathForResource:@"gaki"ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:path];
        self.voice = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
        [self.voice play];
    }
    //timelabelに表示する文字列を設定
    self.timelabel.text = [NSString stringWithFormat:@"%02d:%02d",minute,seconds];
    self.fukidashi.hidden = NO;
    //countが2で割り切れるか
    if (count % 2 == 0) {
        //はよ行け!という文字列と一緒であるか
        if ([self.fukidashi.text isEqualToString:@"はよ行け!"]) {
            //表示する文字列をすぐ行けと設定
            self.fukidashi.text = @"すぐ行け!";
        } else {
            //表示する文字列をはよ行けと設定
            self.fukidashi.text = @"はよ行け!";
            
        }
    }
    
}
@end
