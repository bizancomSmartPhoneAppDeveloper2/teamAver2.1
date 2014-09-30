//
//  ViewController.h
//  KOKOIKE
//
//  Created by ビザンコムマック０７ on 2014/09/25.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
//移動手段を決めるための選択肢のプロパティ
@property (weak, nonatomic) IBOutlet UIPickerView *movepicker;
//ボタンを押したときに呼ばれるメソッド
- (IBAction)firstmove:(id)sender;
//キャラクター用のイメージビュー
@property (weak, nonatomic) IBOutlet UIImageView *charaImg;
@end

