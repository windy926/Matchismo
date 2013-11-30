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

@property (nonatomic) NSInteger matchMode;

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (NSArray *)chooseCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

- (NSUInteger)cardsCount;

@end
