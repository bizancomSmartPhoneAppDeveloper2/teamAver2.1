//
//  FailViewController.h
//  KOKOIKE
//
//  Created by ビザンコムマック０７ on 2014/09/29.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FailViewController : UIViewController
//背景
@property (weak, nonatomic) IBOutlet UIImageView *ctBack;
//フキダシ
@property (weak, nonatomic) IBOutlet UIImageView *ctSerifImage;
//ボタン押した後の集中線
@property (weak, nonatomic) IBOutlet UIImageView *ctEffectImage;
@end
