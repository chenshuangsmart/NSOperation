//
//  CSOperation.m
//  NSOperation
//
//  Created by cs on 2018/6/23.
//  Copyright © 2018年 cs. All rights reserved.
//

#import "CSOperation.h"

@implementation CSOperation

- (void)main {
    if (!self.isCancelled) {
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"%d---%@",i, [NSThread currentThread]); // 打印当前线程
        }
    }
}

@end
