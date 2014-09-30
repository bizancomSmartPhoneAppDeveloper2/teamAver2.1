//
//  notFoundViewController.m
//  KOKOIKE
//
//  Created by ビザンコムマック　13 on 2014/09/30.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "notFoundViewController.h"

@interface notFoundViewController ()

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

- (IBAction)backBtn:(UIButton *)sender {
    [self performSelector:@selector(backTop) withObject:nil afterDelay:3];
}

@end
