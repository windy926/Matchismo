//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by qsu on 13-11-30.
//  Copyright (c) 2013年 Qi Su. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)deck
{
    if (!super.deck) super.deck = [[PlayingCardDeck alloc] init];
    return super.deck;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.cardMathingGame.matchMode = 2;
}

@end
