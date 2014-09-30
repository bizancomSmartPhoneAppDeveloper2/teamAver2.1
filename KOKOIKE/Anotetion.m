//
//  Anotetion.m
//  KOKOIKE
//
//  Created by ビザンコムマック０７ on 2014/09/28.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//
//マップにアノテーションを追加するためのクラス
//

#import "Anotetion.h"

@implementation Anotetion

//アクセサメソッドを自動生成
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

//初期化用のメソッド
-(id)initwithCoordinate:(CLLocationCoordinate2D)co{
    coordinate = co;
    return self;
}

@end
