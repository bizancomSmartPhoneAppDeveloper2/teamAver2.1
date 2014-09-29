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
    //名前がfirstsegueであるセグエを実行
    [self performSegueWithIdentifier:@"firstsegue" sender:self];
}


//セグエ(画面遷移)が実行される前によばれるメソッド
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}
@end
