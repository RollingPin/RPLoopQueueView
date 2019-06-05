//
//  RPLoopQueueView.m
//  RPLoopQueueView
//
//  Created by Tao on 2019/6/5.
//  Copyright © 2019 Tao. All rights reserved.
//

#import "RPLoopQueueView.h"
#import "UIView+Ext.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#define randomColor [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0f]

@interface RPLoopQueueView ()

@property (nonatomic, strong) UIScrollView * bgScrollView;

@property (nonatomic, strong) NSTimer * cellScroTimer; //cell滚动用定时器
@property (nonatomic,assign) int cellScroTimer_yu; //cell滚动用定时器f阈值
@property (nonatomic,assign) int cellScroTimer_yu_jsh; //cell滚动用定时器f阈值计数

@end

@implementation RPLoopQueueView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgScrollView];
        
        _keepSecond = 2;    //默认2s
    }
    return self;
}

- (void)setKeepSecond:(int)keepSecond
{
    _keepSecond = keepSecond;
}

- (void)setInfoArr:(NSArray *)infoArr
{
    _infoArr = infoArr;
    
    self.bgScrollView.contentSize = CGSizeMake(self.width, infoArr.count*self.height);
    
    [self setLoopView];
}

- (void)setLoopView
{
    for (int i = 0; i<self.infoArr.count+2; i++) {
        
        UIButton * cellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cellBtn.frame = CGRectMake(0, self.height*i,self.width, self.height);
        cellBtn.tag = 100+i;
        [cellBtn addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgScrollView addSubview:cellBtn];
        
        NSDictionary * cellInfoDic;
        if (i == 0) {
            cellInfoDic = self.infoArr.lastObject;
        }else if (i == self.infoArr.count+1){
            cellInfoDic = self.infoArr.firstObject;
        }else{
            cellInfoDic = self.infoArr[i-1];
        }
        
        // ==================>>>>>>>>>
        // 此处可编辑需要滚动的view内容,可添加自定义subView,对应self.infoArr数据源内容
        
        UIImageView * imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cellBtn.height, cellBtn.height)];
        imgV.layer.cornerRadius = cellBtn.height/2;
        imgV.layer.masksToBounds = YES;
        [cellBtn addSubview:imgV];

        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(imgV.rightX, 0, cellBtn.width-imgV.width, cellBtn.height)];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor blackColor];
        [cellBtn addSubview:label];

        //赋值

        imgV.image = [UIImage imageNamed:[cellInfoDic objectForKey:@"img"]];
        label.text = [cellInfoDic objectForKey:@"content"];
        
        // <<<<<<<<<==================
        
        
    }
    
    [self addTimer];
}
- (void)cellClick:(UIButton *)btn
{
}

- (void)cellScroTimerFired:(NSTimer *)timer
{
    if (self.cellScroTimer_yu) {
        self.cellScroTimer_yu_jsh = self.cellScroTimer_yu_jsh+1;
        
        if (self.cellScroTimer_yu_jsh == 100*_keepSecond) {
            //触碰阈值计数值,触发阈值变化
            self.cellScroTimer_yu = 0;
            self.cellScroTimer_yu_jsh = 0;
            
            if (self.bgScrollView.contentOffset.y >= self.infoArr.count*self.height) {
                self.bgScrollView.contentOffset = CGPointMake(0, 0);
            }
        }
    }else{
        self.cellScroTimer_yu_jsh = self.cellScroTimer_yu_jsh+1;
        if (self.cellScroTimer_yu_jsh == 100) {
            self.cellScroTimer_yu = 1;
            self.cellScroTimer_yu_jsh = 0;
        }else{
            self.bgScrollView.contentOffset = CGPointMake(0, self.bgScrollView.contentOffset.y+self.height/100);
        }
    }
    
}

- (void)addTimer {
    if (_cellScroTimer) {
        return;
    }
    _cellScroTimer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(cellScroTimerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_cellScroTimer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    if (!_cellScroTimer) {
        return;
    }
    [_cellScroTimer invalidate];
    _cellScroTimer = nil;
}

- (void)showMsg:(NSString *)msg
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle: UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:alert animated:true completion:nil];
}

- (UIScrollView *)bgScrollView
{
    if (_bgScrollView == nil) {
        _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _bgScrollView.scrollEnabled = NO;
    }
    return _bgScrollView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
