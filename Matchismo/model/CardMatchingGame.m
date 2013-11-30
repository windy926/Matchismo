//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Qi Su on 13-11-17.
//  Copyright (c) 2013年 Qi Su. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)setMatchMode:(NSInteger)matchMode
{
    _matchMode = matchMode == 1 ? 1 : 0;
}

- (NSUInteger)cardsCount
{
    return [self.cards count];
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 1;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSArray *)chooseCardAtIndex:(NSUInteger)index
{
    NSMutableArray *chooseResult = [[NSMutableArray alloc] init];
    NSInteger scoreChange = 0;
    
    Card *card = [self cardAtIndex:index];
    [chooseResult addObject:card];
    if (card.isChosen) {
        card.chosen = NO;
        scoreChange = 0;
    } else if (!card.isMatched) {
        Card *otherCard1 = nil;
        Card *otherCard2 = nil;
        int chooseCount = 1;
        for (Card *otherCard in [self cards]) {
            if (otherCard.isChosen && !otherCard.isMatched) {
                [chooseResult addObject:otherCard];
                chooseCount++;
                if (chooseCount == 2) {
                    otherCard1 = otherCard;
                } else if (chooseCount == 3) {
                    otherCard2 = otherCard;
                    break;
                }
            }
        }
        
        if (chooseCount == 2 && self.matchMode == 0) {
            int matchScore = [card match:@[otherCard1]];
            if (matchScore) {
                int addScore = matchScore * MATCH_BONUS;
                self.score += addScore;
                otherCard1.matched = YES;
                card.matched = YES;
                scoreChange = addScore;
//                self.chooseResult = [NSAttributedString][NSString stringWithFormat:@"Matched %@ %@ for %d points", card.contents, otherCard1.contents, addScore];
            } else { // those two cards don't match each other
                self.score -= MISMATCH_PENALTY;
                otherCard1.chosen = NO;
                scoreChange = MISMATCH_PENALTY * -1;
//                self.chooseResult = [NSString stringWithFormat:@"%@ %@ don't match! %d point penalty", card.contents, otherCard1.contents, MISMATCH_PENALTY];
            }
            
        } else if(chooseCount == 3 && self.matchMode == 1) {
            int matchScore = [card match:@[otherCard1, otherCard2]];
            if (matchScore) {
                int addScore = matchScore * MATCH_BONUS;
                self.score += addScore;
                otherCard1.matched = YES;
                otherCard2.matched = YES;
                card.matched = YES;
                scoreChange = addScore;
 //               self.chooseResult = [NSString stringWithFormat:@"Matched %@ %@ %@ for %d points", card.contents, otherCard1.contents, otherCard2.contents, addScore];
            } else { // those two cards don't match each other
                self.score -= MISMATCH_PENALTY;
                otherCard1.chosen = NO;
                otherCard2.chosen = NO;
                scoreChange = MISMATCH_PENALTY * -1;
 //               self.chooseResult = [NSString stringWithFormat:@"%@ %@ %@ don't match! %d point penalty", card.contents, otherCard1.contents, otherCard2.contents, MISMATCH_PENALTY];
            }
        }
        self.score -= COST_TO_CHOOSE;
        card.chosen = YES;
        
    }
 //   [chooseResult addObject:[[NSNumber alloc] initWithInteger:scoreChange]];
    if (scoreChange > 0)
    {
        NSMutableArray *matchIndex = [[NSMutableArray alloc] init];
        for (Card *card in chooseResult) {
            NSUInteger index = [chooseResult indexOfObject:card];
            [matchIndex addObject:[NSNumber numberWithUnsignedInteger:index]];
        }
        for (NSNumber *index in matchIndex) {
            [self.cards removeObjectAtIndex:[index unsignedIntegerValue]];
        }
        return matchIndex;
    } else
        return nil;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return index < [self.cards count] ? self.cards[index] : nil;
}


@end
