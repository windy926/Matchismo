//
//  PlayingCard.m
//  Matchismo
//
//  Created by Qi Su on 13-11-17.
//  Copyright (c) 2013年 Qi Su. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard ()

@end

@implementation PlayingCard

+ (NSArray *)validSuits
{
    return @[@"♥︎", @"♦︎", @"♠︎", @"♣︎"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[PlayingCard rankStrings] count] - 1;
}

- (NSString *)rankAsString
{
    return [PlayingCard rankStrings][self.rank];
}

- (NSString *)contents
{
    NSString *contents = [NSString stringWithFormat:@"%@%@", [[PlayingCard rankStrings] objectAtIndex:self.rank], self.suit];
    
    return contents;
}
                

@synthesize suit = _suit; //since getter and setter are all defined

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
        _suit = suit;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
        _rank = rank;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    [cards addObject:self];
    
    for (Card *card in otherCards) {
        [cards addObject:card];
    }
    
    for (int i = 0; i < cards.count; i++) {
        for (int j = i + 1; j < cards.count; j++) {
            PlayingCard *card1 = cards[i];
            PlayingCard *card2 = cards[j];
            if (card1.rank == card2.rank) {
                score += 4;
            } else if([card1.suit isEqualToString:card2.suit]) {
                score += 1;
            }
        }
    }
    return score;
}

@end
