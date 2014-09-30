//
//  FailViewController2.m
//  KOKOIKE
//
//  Created by ビザンコムマック　13 on 2014/09/30.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "FailViewController2.h"
//音源用のフレームワーク2つインポート
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface FailViewController2 ()
//音源用のプロパティを宣言
@property AVAudioPlayer *fakeSound;

@end

@implementation FailViewController2{
    NSArray *imageNames; //画像ファイル名の入る配列
    NSInteger index; //画像表示のためのint型のカウンタ変数
    NSInteger length; //画像の最大数を数えるためのint型の変数
    NSTimer *myTimer; //NSTimerクラスのmyTimerというインスタンスを作成
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self changeBack];
    [self soundDrum];
    //最初は画面全体のボタンを無効にしておく
    _btnBack.enabled = NO;
    
    //フェイクアクション用の配列
    imageNames = [NSArray arrayWithObjects:
                  @"hackMail01",
                  @"hackMail02",
                  @"hackMail03",
                  @"hackMail04",
                  @"hackMail05",
                  @"hackMail06",
                  @"hackMail07",nil];
    
    //画面が開いた時にはindexに0が入っている状態にする
    index = 0;
    length = imageNames.count;
    
    //2秒後と5秒後にセリフを変える
    [self performSelector:@selector(changeSerif1) withObject:nil afterDelay:2];
    [self performSelector:@selector(changeSerif2) withObject:nil afterDelay:5];
    
    //8秒後にフェイクアクション開始
    [self performSelector:@selector(slideStart) withObject:nil afterDelay:8];
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
    NSMutableArray *imageList = [NSMutableArray array];
    for (NSInteger i = 1; i < 13; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"hackBack%02ld.png", (long)i];
        UIImage *img = [UIImage imageNamed:imagePath];
        [imageList addObject:img];
    }
    self.imageView.animationImages = imageList;
    self.imageView.animationDuration = 1.5;// アニメーションの間隔
    self.imageView.animationRepeatCount = 0;// ?回リピート 0なら永遠に
    [self.imageView startAnimating];
}

//最初のセリフを表示するメソッド
-(void)changeSerif1{
    self.ptSerifImage.image = [UIImage imageNamed:@"hackSerif01"];
}

//次のセリフを表示するメソッド
-(void)changeSerif2{
    self.ptSerifImage.image = [UIImage imageNamed:@"hackSerif02"];
}

//フェイクアクション関係メソッド集
-(void)slideStart{
    myTimer=[NSTimer scheduledTimerWithTimeInterval:0.7
                                             target:self
                                           selector:@selector(showNextImage:) //@selectorはメソッドを表す()内はメソッド名
                                           userInfo:nil
                                            repeats:YES
             ];
}
//次の画像を表示するメソッド
-(void)showNextImage: (NSTimer *)timer {
    if (index < length) {
        [self showImage:imageNames[index]];
        //音がなる
        NSString *path = [[NSBundle mainBundle]pathForResource:@"iphonedefault_an"ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        self.fakeSound = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
        [self.fakeSound play];
        //indexに１を足す
        index++;
    }else{
        [timer invalidate];
        self.btnBack.enabled = YES;
    }
}

-(void)showImage:(NSString *)imageName{
    self.fakeActionView.image = [UIImage imageNamed:imageName];
}

-(void)soundDrum{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"se_maoudamashii_instruments_drumroll"ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.fakeSound = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
    [self.fakeSound play];
}

//起動画面に戻るメソッド
-(void)backTop{
    [self performSegueWithIdentifier:@"fv2ToTop" sender:self];
}

- (IBAction)btnBack:(UIButton *)sender {
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
    self.charView.image = [UIImage imageNamed:@"topChar07"]; //ファイル名を変数という形でもらう
    // Sart Animating!
    [self.charView startAnimating];
    
    [self performSelector:@selector(backTop) withObject:nil afterDelay:5];
}
@end
