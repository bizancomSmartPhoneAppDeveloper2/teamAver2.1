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
//レストランの名前を表示するラベル
@property (weak, nonatomic) IBOutlet UILabel *resname;
//戻るボタンを押したときによばれるメソッド
- (IBAction)back:(id)sender;
//戻るボタン
@property (weak, nonatomic) IBOutlet UIButton *backbutton;

@end
