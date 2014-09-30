//
//  FailViewController.m
//  KOKOIKE
//
//  Created by ビザンコムマック０７ on 2014/09/29.
//  Copyright (c) 2014年 mycompany. All rights reserved.
// 失敗したときの画面を管理するクラス

#import "FailViewController.h"
//音源用のフレームワーク2つインポート
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface FailViewController ()
//音源用のプロパティを宣言
@property AVAudioPlayer *alertSound;


@end

@implementation FailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self changeBack];
    //1.5秒後にサイレンが鳴り始める
    [self performSelector:@selector(siren) withObject:nil afterDelay:1.5];
    //2秒後にセリフが変わる
    [self performSelector:@selector(changeSerif) withObject:nil afterDelay:2];
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

//背景のアニメーションメソッド
-(void)changeBack{
    // アニメーション用画像を配列（imageList）にセット
    NSMutableArray *imageList = [NSMutableArray array];
    for (NSInteger i = 1; i <= 2; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"cauBack%02ld.png", (long)i];
        UIImage *img = [UIImage imageNamed:imagePath];
        [imageList addObject:img];
    }
    self.ctBack.animationImages = imageList;
    self.ctBack.animationDuration = 1;// アニメーションの間隔
    self.ctBack.animationRepeatCount = 0;// ?回リピート 0なら永続
    // Sart Animating!
    [self.ctBack startAnimating];
}

//セリフのアニメーションメソッド
-(void)changeSerif{
    NSMutableArray *imageList = [NSMutableArray array];
    for (NSInteger i = 1; i <= 2; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"cauSerif%02ld.png", (long)i];
        UIImage *img = [UIImage imageNamed:imagePath];
        [imageList addObject:img];
    }
    self.ctSerifImage.animationImages = imageList;
    self.ctSerifImage.animationDuration = 7;
    self.ctSerifImage.animationRepeatCount = 0;
    // Sart Animating!
    [self.ctSerifImage startAnimating];
}

//エフェクトのアニメーションメソッド
-(void)penaEffect{
    NSMutableArray *imageList = [NSMutableArray array];
    for (NSInteger i = 1; i <= 2; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"cauEffect%02ld.png", (long)i];
        UIImage *img = [UIImage imageNamed:imagePath];
        [imageList addObject:img];
    }
    self.ctEffectImage.animationImages = imageList;
    self.ctEffectImage.animationDuration = 0.5;
    self.ctEffectImage.animationRepeatCount = 0;
    // Sart Animating!
    [self.ctEffectImage startAnimating];
}

//失敗画面2へ移動するメソッド
-(void)toFV2{
    [self performSegueWithIdentifier:@"failsegue2" sender:self];
    [self.alertSound stop];
}

//サイレンを鳴らすメソッド
-(void)siren{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"siren"ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.alertSound = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
    self.alertSound.numberOfLoops = -1; //-1で繰り返し鳴らす
    [self.alertSound play];
}

//画面全体がボタンになっている
- (IBAction)btnBack:(UIButton *)sender {
    [self penaEffect];
    [self performSelector:@selector(toFV2) withObject:nil afterDelay:3];
}

@end
