//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by qsu on 13-11-30.
//  Copyright (c) 2013年 Qi Su. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCardView.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)deck
{
    if (!super.deck) super.deck = [[SetCardDeck alloc] init];
    return super.deck;
}

- (void)initCardMathingGameAndCardViews
{
    [super initCardMathingGameAndCardViews];
    self.cardMathingGame.matchMode = GAME_MODE_3_CARD;
}

- (CardView *)newCardView
{
    SetCardView *setCardView = [[SetCardView alloc] init];
    return setCardView;
}

- (IBAction)touch3MoreCardsButton
{
    BOOL success = [self.cardMathingGame draw3MoreCardsFromDeck:self.deck];
    
    [self updateCardViews];
    
    [self updateUI];
    [self reputCardViews];
}

@end
