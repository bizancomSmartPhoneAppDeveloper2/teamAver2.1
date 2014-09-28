//
//  Anotetion.h
//  KOKOIKE
//
//  Created by ビザンコムマック０７ on 2014/09/28.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface Anotetion : NSObject<MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}
//緯度、経度の情報を格納するための変数
@property(nonatomic)CLLocationCoordinate2D coordinate;
//タイトルを持つ変数
@property(nonatomic,copy)NSString *title;
//サブタイトルを持つ変数
@property(nonatomic,copy)NSString *subtitle;
//初期化用のメソッド
-(id)initwithCoordinate:(CLLocationCoordinate2D)co;

@end
