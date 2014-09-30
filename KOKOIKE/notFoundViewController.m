//
//  notFoundViewController.m
//  KOKOIKE
//
//  Created by ビザンコムマック　13 on 2014/09/30.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "notFoundViewController.h"
//音源用のフレームワーク2つインポート
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface notFoundViewController ()
@property AVAudioPlayer *mySound;
@end

@implementation notFoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self changeBack];
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
-(void)changeBack{
    NSMutableArray *imageList = [NSMutableArray array];
    for (NSInteger i = 1; i <= 2; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"ntBack%02ld.png", (long)i];
        UIImage *img = [UIImage imageNamed:imagePath];
        [imageList addObject:img];
    }
    self.ntBack.animationImages = imageList;
    self.ntBack.animationDuration = 1;// アニメーションの間隔
    self.ntBack.animationRepeatCount = 0;// ?回リピート 0なら永続
    [self.ntBack startAnimating];
}

-(void)fukidasi{
    self.ntSerifImage.image = [UIImage imageNamed:@"ntFukidasi"];
}

//セグエを実行
-(void)backTop{
    [self performSegueWithIdentifier:@"notFoundToTop" sender:self];
}

//「ココイケ」と発音するメソッド
-(void)sayKokoike{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"kokoike"ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.mySound = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
    [self.mySound play];
}

//画面全体がボタンです
- (IBAction)backBtn:(UIButton *)sender {
    // アニメーション用画像を配列（imageList）にセット
    NSMutableArray *imageList = [NSMutableArray array];
    for (NSInteger i = 1; i <= 7; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"topChar%02ld.png", (long)i];
        UIImage *img = [UIImage imageNamed:imagePath];
        [imageList addObject:img];
    }
    self.charView.animationImages = imageList;
    self.charView.animationDuration = 0.3;// アニメーションの間隔
    self.charView.animationRepeatCount = 1;// ?回リピート 0なら永続
    self.charView.image = [UIImage imageNamed:@"topChar07"];
    // Sart Animating!
    [self.charView startAnimating];
    
    [self performSelector:@selector(sayKokoike) withObject:nil afterDelay:2];
    [self performSelector:@selector(backTop) withObject:nil afterDelay:3];
}

@end
