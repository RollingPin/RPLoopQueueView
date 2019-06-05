//
//  ViewController.m
//  RPLoopQueueView
//
//  Created by Tao on 2019/6/5.
//  Copyright © 2019 Tao. All rights reserved.
//

#import "ViewController.h"
#import "RPLoopQueueView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableDictionary * dic0 = [NSMutableDictionary dictionary];
    dic0[@"img"] = @"rpImg_00.jpg";
    dic0[@"content"] = @"===>>>>>>我是第0个<<<<<<===";
    
    NSMutableDictionary * dic1 = [NSMutableDictionary dictionary];
    dic1[@"img"] = @"rpImg_01.jpg";
    dic1[@"content"] = @"===>>>>>>我是第1个<<<<<<===";
    
    NSMutableDictionary * dic2 = [NSMutableDictionary dictionary];
    dic2[@"img"] = @"rpImg_02.jpg";
    dic2[@"content"] = @"===>>>>>>我是第2个<<<<<<===";
    
    NSMutableArray * infoArr = [NSMutableArray array];
    [infoArr addObject:dic0];
    [infoArr addObject:dic1];
    [infoArr addObject:dic2];
    
    RPLoopQueueView * loopView = [[RPLoopQueueView alloc]initWithFrame:CGRectMake(16, 200, self.view.frame.size.width-32, 50)];
    loopView.keepSecond = 2;
    loopView.infoArr = infoArr;
    [self.view addSubview:loopView];
}


@end
