//
//  SucessViewController.m
//  KOKOIKE
//
//  Created by ビザンコムマック０７ on 2014/09/29.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "SucessViewController.h"
//音源用のフレームワーク2つインポート
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SucessViewController ()
@property AVAudioPlayer *mySound;

@end

@implementation SucessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self changeBack];
    [self performSelector:@selector(rappa) withObject:nil afterDelay:0.3];
    
    //2秒後にフキダシを表示
    [self performSelector:@selector(fukidasi) withObject:nil afterDelay:2];
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
//背景のアニメーション
-(void)changeBack{
    NSMutableArray *imageList = [NSMutableArray array];
    for (NSInteger i = 1; i <= 2; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"mcBack%02ld.png", (long)i];
        UIImage *img = [UIImage imageNamed:imagePath];
        [imageList addObject:img];
    }
    self.mcBack.animationImages = imageList;
    self.mcBack.animationDuration = 1;// アニメーションの間隔
    self.mcBack.animationRepeatCount = 0;// ?回リピート 0なら永続
    [self.mcBack startAnimating];
}

//フキダシを表示
-(void)fukidasi{
    self.mcSerifImage.image = [UIImage imageNamed:@"mcFukidashi"]; //ファイル名を変数という形でもらう
}

//ラッパの音
-(void)rappa{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"trumpet1"ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.mySound = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
    [self.mySound play];
}

//セグエを実行
-(void)startGPS{
    [self performSegueWithIdentifier:@"SucessToTop" sender:self];
}

//画面全体がボタンです
- (IBAction)backBtn:(UIButton *)sender {
    [self performSelector:@selector(startGPS) withObject:nil afterDelay:1.2];
}
@end
