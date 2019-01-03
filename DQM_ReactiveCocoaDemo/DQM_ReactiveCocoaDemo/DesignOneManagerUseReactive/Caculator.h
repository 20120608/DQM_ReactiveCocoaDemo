//
//  Caculator.h
//  DQM_ReactiveCocoaDemo
//
//  Created by 漂读网 on 2018/12/29.
//  Copyright © 2018 漂读网. All rights reserved.
//


//计算器
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Caculator : NSObject

/** 结果 */
@property(nonatomic,assign) double          result;

/** 是否等于某个值 */
@property(nonatomic,assign) BOOL          isEqual;

+ (instancetype)sharedInstance;

- (Caculator *)add:(double(^)(double result))caculator;

- (Caculator *)equal:(BOOL(^)(double result))operation;


@end

NS_ASSUME_NONNULL_END
