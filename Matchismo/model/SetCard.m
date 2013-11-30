//
//  SetCard.m
//  Matchismo
//
//  Created by Qi Su on 13-11-19.
//  Copyright (c) 2013年 Qi Su. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

#pragma mark - Properties

+ (NSArray *)validNumbers
{
    return @[[NSNumber numberWithInteger:1], [NSNumber numberWithInteger:2], [NSNumber numberWithInteger:3]];
}

+ (NSArray *)validSymbols { return @[@"▴", @"●", @"■"]; }

+ (NSArray *)validShadings
{
    return @[@"solid", @"striped", @"open"];
}

+ (NSArray *)validColors { return @[@"red", @"green", @"purple"]; }

- (NSString *)contents
{
    NSString *contents= [[NSString alloc] init];
    
    for (int i = 0; i < [self.number integerValue]; i++)
        contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@", self.symbol]];
 //   contents = [contents stringByAppendingString:[NSString stringWithFormat:@"%@", self.symbol]];
    
//    
//    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] initWithString:text];
//    [contents setAttributes:@{NSForegroundColorAttributeName: [self getColor],
//                              NSStrokeWidthAttributeName: @-3,
//                              NSStrokeColorAttributeName: [self getColor]}
//                      range:NSMakeRange(0, [contents length])];
    return contents;
}

- (void)setNumber:(NSNumber *)number
{
    if ([[SetCard validNumbers] containsObject:number])
        _number = number;
    else
        _number = 0;
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol])
        _symbol = symbol;
    else
        _symbol = @"?";
}

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading])
        _shading = shading;
    else
        _shading = 0;
}

#pragma mark - Matching

- (int)match:(NSArray *)otherCards
{
    if ([otherCards count] != 2) {
        return 0;
    }
    
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    [cards addObject:self];
    [cards addObject:otherCards[0]];
    [cards addObject:otherCards[1]];
    
    NSMutableArray *setToCheck = [[NSMutableArray alloc] init];
    for(id i in cards) {
        SetCard *card = (SetCard *)i;
        [setToCheck addObject:card.number];
    }
    if (![self checkSet:setToCheck]) {
        return 0;
    }
    
    [setToCheck removeAllObjects];
    for(id i in cards) {
        SetCard *card = (SetCard *)i;
        [setToCheck addObject:card.symbol];
    }
    if (![self checkSet:setToCheck]) {
        return 0;
    }
    
    [setToCheck removeAllObjects];
    for(id i in cards) {
        SetCard *card = (SetCard *)i;
        [setToCheck addObject:card.shading];
    }
    if (![self checkSet:setToCheck]) {
        return 0;
    }
    
    [setToCheck removeAllObjects];
    for(id i in cards) {
        SetCard *card = (SetCard *)i;
        [setToCheck addObject:card.color];
    }
    if (![self checkSet:setToCheck]) {
        return 0;
    }
    
    return 9;
}

- (BOOL)checkSet:(NSArray *)setToCheck
{
    
    NSMutableSet *set = [[NSMutableSet alloc] init];
    [set addObjectsFromArray:setToCheck];
    
    if ([set count] == 1 || [set count] == [setToCheck count])
        return YES;
    else
        return NO;
}


@end
