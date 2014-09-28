//
//  ViewController.m
//  KOKOIKE
//
//  Created by ビザンコムマック０７ on 2014/09/25.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    //お金の選択肢の要素を決めるための配列
    NSArray *money;
    //移動手段の要素を決めるための配列
    NSArray *move;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    //配列の初期化
    move = [NSArray arrayWithObjects:@"徒歩",@"自転車",@"車", nil];
    money = [NSArray arrayWithObjects:@"500円以下",@"800円以下",@"1000円以下" ,@"1500円以下",@"制限なし",nil];
    //デリゲートとデータソースを自分自身に設定
    self.movepicker.delegate = self;
    self.movepicker.dataSource = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ピッカーに表示する列数を設定するためのメソッド
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//ピッカーに表示する行数を設定するためのメソッド
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
   
         //1列目をmoveの要素分表示するように設定
        return [move count];
    
}

//ピッカーに表示する内容を設定するためのメソッド
//引数rowに行番号、componentに列番号が渡されている
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
        return [move objectAtIndex:row];

}

//ボタンをおしたときに呼ばれるメソッド
- (IBAction)firstmove:(id)sender {
    //名前がfirstsegueであるセグエを実行
    [self performSegueWithIdentifier:@"firstsegue" sender:self];
}


//セグエ(画面遷移)が実行される前によばれるメソッド
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //画面遷移されるビューの情報を格納
    SecondViewController *sec = segue.destinationViewController;
    //プロパティmoveにmovepickerで選ばれた文字列を格納
    sec.move = [move objectAtIndex:[self.movepicker selectedRowInComponent:0]];
}
@end
