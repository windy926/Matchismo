//
//  SetCard.h
//  Matchismo
//
//  Created by Qi Su on 13-11-19.
//  Copyright (c) 2013年 Qi Su. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading; // of NSAttributedString attributeName
@property (strong, nonatomic) NSString *color;

+ (NSArray *)validNumbers;

+ (NSArray *)validSymbols;

+ (NSArray *)validShadings;

+ (NSArray *)validColors;

@end
