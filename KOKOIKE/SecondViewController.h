//
//  SecondViewController.h
//  KOKOIKE
//
//  Created by ビザンコムマック０７ on 2014/09/25.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SecondViewController : UIViewController
//移動手段の文字列を格納する変数
@property (nonatomic) NSString *move;
//お金に関する情報を格納する変数
@property (nonatomic) NSString *money;
//画面遷移されたときにお待ちくださいと表示されるラベル
@property (weak, nonatomic) IBOutlet UILabel *label;
//インジケーター
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
//マップ
@property (weak, nonatomic) IBOutlet MKMapView *map;
//制限時間を表示するためのラベル
@property (weak, nonatomic) IBOutlet UILabel *timelabel;
//吹き出しの中に表示されるラベル
@property (weak, nonatomic) IBOutlet UILabel *fukidashi;

@end
