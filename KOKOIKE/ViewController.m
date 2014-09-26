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
    self.moneypicker.delegate = self;
    self.moneypicker.delegate = self;
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
   
    if (pickerView == self.movepicker) {
         //1列目をmoveの要素分表示するように設定
        return [move count];
    } else{
        //2列目をmoneyの要素分表示するように設定
        return [money count];
    }
}

//ピッカーに表示する内容を設定するためのメソッド
//引数rowに行番号、componentに列番号が渡されている
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == self.movepicker) {
        //1列目にmoveの要素を表示するように設定
        return [move objectAtIndex:row];
    } else {
        //2列目にmoneyの要素を表示させるように設定
        return [money objectAtIndex:row];
    }
}
- (IBAction)firstmove:(id)sender {
    [self performSegueWithIdentifier:@"firstsegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    SecondViewController *sec = segue.destinationViewController;
    sec.move = [move objectAtIndex:[self.movepicker selectedRowInComponent:0]];
    sec.money = [money objectAtIndex:[self.moneypicker selectedRowInComponent:0]];
}
@end
