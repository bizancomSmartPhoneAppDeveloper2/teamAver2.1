//
//  ViewController.m
//  KOKOIKE
//
//  Created by ビザンコムマック０７ on 2014/09/25.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController (){
    //お金の選択肢の要素を決めるための配列
    NSArray *money;
    //移動手段の要素を決めるための配列
    NSArray *move;
}

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
    [self niyari];
    //名前がfirstsegueであるセグエを実行
    [self performSegueWithIdentifier:@"firstsegue" sender:self];
}


//セグエ(画面遷移)が実行される前によばれるメソッド
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

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
@end
