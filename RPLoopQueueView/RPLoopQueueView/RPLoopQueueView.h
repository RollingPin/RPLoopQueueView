//
//  RPLoopQueueView.h
//  RPLoopQueueView
//
//  Created by Tao on 2019/6/5.
//  Copyright © 2019 Tao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RPLoopQueueView : UIView

@property (nonatomic, strong) NSArray * infoArr;//输入数据源

@property (nonatomic, assign) int keepSecond;   //静止展示时间,秒

@end

NS_ASSUME_NONNULL_END
