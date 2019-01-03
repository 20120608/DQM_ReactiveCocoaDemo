//
//  Caculator.m
//  DQM_ReactiveCocoaDemo
//
//  Created by 漂读网 on 2018/12/29.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "Caculator.h"

@implementation Caculator

+ (instancetype)sharedInstance {
  static Caculator *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

- (Caculator *)add:(double (^)(double))caculator
{
  _result = caculator(_result);
  return self;
}

- (Caculator *)equal:(BOOL (^)(double))operation
{
  _isEqual = operation(_result);
  return self;
}

@end
