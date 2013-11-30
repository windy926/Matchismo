//
//  CardGameViewController.m
//  Matchismo
//
//  Created by qsu on 13-11-29.
//  Copyright (c) 2013年 Qi Su. All rights reserved.
//

#import "CardGameViewController.h"
#import "Grid.h"
#import "CardView.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UIView *allCardsView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) NSMutableArray *cardViews; // of CardView
@property (strong, nonatomic) Grid *cardsGrid;
@end

@implementation CardGameViewController

- (NSMutableArray *)cardViews
{
    if (!_cardViews) _cardViews = [[NSMutableArray alloc] init];
    return _cardViews;
}

- (void)initCardMathingGameAndCardViews
{
    self.cardMathingGame = [[CardMatchingGame alloc] initWithCardCount:12
                                                         usingDeck:self.deck];
    for (CardView *card in self.cardViews) {
        [card removeFromSuperview];
    }
    [self.cardViews removeAllObjects];
    
    for (int i = 0; i < [self.cardMathingGame cardsCount]; i++) {
        CardView *newCard = [self newCardViewForCard:[self.cardMathingGame cardAtIndex:i]];
        newCard.frame = CGRectMake(0, 0, 0, 0);
        [self.cardViews addObject:newCard];
        [self.allCardsView addSubview:newCard];
    }
}

- (CardView *)newCardViewForCard:(Card *)card
{
    CardView *cardView = [[CardView alloc] init];
    cardView.card = card;
    return cardView;
}

- (Grid *)cardsGrid
{
    if (!_cardsGrid) _cardsGrid = [[Grid alloc] init];
    
    _cardsGrid.cellAspectRatio = 0.618;
    _cardsGrid.size = self.allCardsView.bounds.size;
    _cardsGrid.minimumNumberOfCells = [self.cardMathingGame cardsCount];
    
    return _cardsGrid;
}

- (IBAction)redeal
{
    [self initCardMathingGameAndCardViews];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initCardMathingGameAndCardViews];
    [self updateUI];
}

- (void)updateUI
{
    [self reputCardViews];
}

- (void)reputCardViews
{
    for (int i = 0; i < [self.cardViews count]; i++) {
        int row = i / self.cardsGrid.columnCount;
        int column = i % self.cardsGrid.columnCount;
        CardView *cardView = (CardView *)self.cardViews[i];
        cardView.frame = [self.cardsGrid frameOfCellAtRow:row inColumn:column];
    }
}

@end
