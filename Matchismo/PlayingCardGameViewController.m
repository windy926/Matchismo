//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by qsu on 13-11-30.
//  Copyright (c) 2013年 Qi Su. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardView.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)deck
{
    if (!super.deck) super.deck = [[PlayingCardDeck alloc] init];
    return super.deck;
}

- (void)initCardMathingGameAndCardViews
{
    [super initCardMathingGameAndCardViews];
    self.cardMathingGame.matchMode = GAME_MODE_2_CARD;
}

- (CardView *)newCardView
{
    PlayingCardView *playingCardView = [[PlayingCardView alloc] init];
    return playingCardView;
}

@end
