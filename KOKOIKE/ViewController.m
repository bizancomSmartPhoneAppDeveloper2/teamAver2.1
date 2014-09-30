//
//  ViewController.m
//  KOKOIKE
//
//  Created by ビザンコムマック０７ on 2014/09/25.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
//音源用のフレームワーク2つインポート
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController (){
    //お金の選択肢の要素を決めるための配列
    NSArray *money;
    //移動手段の要素を決めるための配列
    NSArray *move;
}
//音源用のプロパティを準備
@property AVAudioPlayer *voice;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ボタンをおしたときに呼ばれるメソッド
- (IBAction)firstmove:(id)sender {
    [self sayKokoike];
    [self niyari];
    [self performSelector:@selector(startGPS) withObject:nil afterDelay:1.2];
}

//セグエ(画面遷移)が実行される前によばれるメソッド
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
}

//セグエを実行
-(void)startGPS{
    //名前がfirstsegueであるセグエを実行
    [self performSegueWithIdentifier:@"firstsegue" sender:self];
}

//キャラクターがニヤリとするメソッド
-(void)niyari{
    NSMutableArray *imageList = [NSMutableArray array];
    for (NSInteger i = 1; i <= 7; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"topChar%02ld.png", (long)i];
        UIImage *img = [UIImage imageNamed:imagePath];
        [imageList addObject:img];
    }
    self.charaImg.animationImages = imageList;
    self.charaImg.animationDuration = 0.3;// アニメーションの間隔
    self.charaImg.animationRepeatCount = 1;// ?回リピート 0なら永続
    self.charaImg.image = [UIImage imageNamed:@"topChar07"];
    // Sart Animating!
    [self.charaImg startAnimating];
}

//「ココイケ」と発音するメソッド
-(void)sayKokoike{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"kokoike"ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.voice = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
    [self.voice play];
}

@end
