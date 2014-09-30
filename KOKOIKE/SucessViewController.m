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
    //ラベルを非表示
    self.label.hidden = YES;
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
    //ラベルを表示
    self.label.hidden = NO;
    //ラベルの表示行数を無限にする
    self.label.numberOfLines = 0;
    self.label.text = @"よくやった褒美にいいこと教えてやるよ";
    [self performSelector:@selector(second) withObject:nil afterDelay:3];
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

//2番目の台詞を表示するメソッド
-(void)second{
    self.label.text = @"一度しか言わないから\n耳の穴かっぽじって\nよく聞けよ";
    [self performSelector:@selector(trivia) withObject:nil afterDelay:3];
}

//豆知識の台詞を表示するメソッド
-(void)trivia{
    //豆知識の文字列を格納している配列
    NSArray *array = [NSArray arrayWithObjects:@"エッフェル塔は\n温度差の関係で夏と冬では\n高さが15センチも違うらしいぜ！",@"「夏が来れば思い出す～」の曲に\n出てくるので有名なミズバショウ。\n食べたら死ぬらしいぜ！", @"ボーリング場の貸し靴が\nセンスのかけらもない色をしているのは\n盗難防止のためらしいぜ！",@"ハンガリー語で塩が足りない事を\n「シオタラン」と言うらしいぜ！",@"恐怖のため落ち着かない\n様子を表す言葉は\n「ろりろり」と言うらしいぜ！",@"バドミントンの審判の判定には\n「よく見えませんでした」\nというものがあるらしいぜ！",@"漢字には音読み、訓読み\nというものがあるが\n訓読みの「訓」は音読みなんだぜ！",@"アラビア語で「お父さん」\nを呼ぶ時に使う言葉は\n「ヤバイ」と言うらしいぜ！",@"「あれ!?」などの驚きの\n言葉をドイツ語で言うと\n「ナヌッ」と言うらしいぜ！",@"ジンジャーエールを冷凍庫に\n",@"90分入れフタを開けると\n一気に凍りだすらしいぜ！",@"タツノオトシゴの仲間には\n「タツノイトコ」と「タツノハトコ」が\nいるらしいぜ！",@"英単語「nice」の元々の意味は\n「バカ」らしいぜ！",@"ライオンはボスが替わると\n元のボスの子供を\n全て殺すらしいぜ！",@"「微妙な三角関係」という言葉は\n韓国語でも「ビミョウナサンカクカンケイ」\nと言うらしいぜ！",@"タバコなどに含まれる\nニコチンは体内に入ると\nコチニンになるなるらしいぜ！",@"「ゴキブリ」はもともと「ゴキカブリ」だったが\n本の印刷ミスから\n「ゴキブリ」となったらしいぜ！",@"シャーペンの芯は\n電子レンジで加熱すると\n光るらしいぜ！",@"鉛筆を振った時ぐにゃぐにゃに見える\n現象の名前は「ラバー・ペンシル・イリュージョン」\nというらしいぜ！",@"中国の「ネイチャン」という町に\n流れている川の名前は\n「トオチャン」というらしいぜ！",@"ヒジがジーンとする\nあの場所の名前は「ファニーボーン」\nというらしいぜ！",nil];
    //ラベルにarrayの中の文字列をランダム表示
    self.label.text = [array objectAtIndex:arc4random()%[array count]];
    
    
}
@end
