//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Qi Su on 13-11-17.
//  Copyright (c) 2013年 Qi Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;

#define GAME_MODE_2_CARD 0
#define GAME_MODE_3_CARD 1
@property (nonatomic) NSInteger matchMode;

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (NSArray *)chooseCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

- (void)removeCard:(Card *)card;

- (NSUInteger)cardsCount;

- (BOOL)draw3MoreCardsFromDeck:(Deck *)deck;

@end
