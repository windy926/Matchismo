//
//  Card.h
//  Matchismo
//
//  Created by Qi Su on 13-11-17.
//  Copyright (c) 2013年 Qi Su. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
