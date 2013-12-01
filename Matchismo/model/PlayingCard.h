//
//  PlayingCard.h
//  Matchismo
//
//  Created by Qi Su on 13-11-17.
//  Copyright (c) 2013年 Qi Su. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

- (NSString *)rankAsString;

+ (NSArray *)validSuits;

+ (NSArray *)rankStrings;

+ (NSUInteger)maxRank;


@end
