//
//  Deck.h
//  Matchismo
//
//  Created by Qi Su on 13-11-17.
//  Copyright (c) 2013年 Qi Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
