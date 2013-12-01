//
//  CardGameViewController.h
//  Matchismo
//
//  Created by qsu on 13-11-29.
//  Copyright (c) 2013年 Qi Su. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"
#import "CardView.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *cardMathingGame;

- (CardView *)newCardView; // abstract
- (void)initCardMathingGameAndCardViews;

- (void)updateCardViews;

- (void)updateUI;
- (void)reputCardViews;
@end
