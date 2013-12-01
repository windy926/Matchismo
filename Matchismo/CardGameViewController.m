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
//@property (strong, nonatomic) NSMutableArray *cardViews; // of CardView
@property (strong, nonatomic) Grid *cardsGrid;
@end

@implementation CardGameViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view setNeedsDisplay];
    [self.allCardsView setNeedsDisplay];
    [self reputCardViews];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self reputCardViews];
}

//- (NSMutableArray *)cardViews
//{
//    if (!_cardViews) _cardViews = [[NSMutableArray alloc] init];
//    return _cardViews;
//}

- (void)initCardMathingGameAndCardViews
{
    self.cardMathingGame = [[CardMatchingGame alloc] initWithCardCount:12
                                                         usingDeck:self.deck];
    [self updateCardViews];
}

- (void)updateCardViews
{
//    for (CardView *card in self.cardViews) {
//        [card removeFromSuperview];
//    }
//    [self.cardViews removeAllObjects];
    for (UIView *card in self.allCardsView.subviews) {
        [card removeFromSuperview];
    }
    
    for (int i = 0; i < [self.cardMathingGame cardsCount]; i++) {
        CardView *newCard = [self newCardView];
        newCard.frame = CGRectMake(0, 0, 0, 0);
//        [self.cardViews addObject:newCard];
        [self.allCardsView addSubview:newCard];
    }
}

- (CardView *)newCardView
{
    return nil;
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
    [self reputCardViews];
    [self updateUI];
}

- (IBAction)tapCard:(UITapGestureRecognizer *)sender
{
    NSArray *matchIndex = nil;
    if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint tapPoint = [sender locationInView:self.allCardsView];
        for (CardView *cardView in self.allCardsView.subviews) {
            if (CGRectContainsPoint(cardView.frame, tapPoint)) {
                matchIndex = [self.cardMathingGame chooseCardAtIndex:[self.allCardsView.subviews indexOfObject:cardView]];
            }
        }
    }
    [self updateUI];
    [self.allCardsView setNeedsDisplay];
    
    if (matchIndex != nil)
        [self removeCardsAtIndexs:matchIndex];
    
    
}

- (void)removeCardsAtIndexs:(NSArray*)indexs
{
    NSMutableArray *removeCardObjects = [[NSMutableArray alloc] init];
    NSMutableArray *removeCardViewObjects = [[NSMutableArray alloc] init];

    for (NSNumber *index in indexs) {
        [removeCardObjects addObject:[self.cardMathingGame cardAtIndex:[index unsignedIntegerValue]]];
        [removeCardViewObjects addObject:[self.allCardsView.subviews objectAtIndex:[index unsignedIntegerValue]]];
    }
    for (Card *card in removeCardObjects) {
        [self.cardMathingGame removeCard:card];
    }
    for (CardView *cardView in removeCardViewObjects) {
        [UIView animateWithDuration:1.0
                              delay:1.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             cardView.alpha = 0.0;
                         }
                         completion:^(BOOL finished) {}];
//        [UIView animateWithDuration:1.0
//                              delay:1.0
//                         animations:^{
//                             cardView.alpha = 0.0;
//                         }];
        [cardView removeFromSuperview];
 //       [self.cardViews removeObject:cardView];
    }
    [self reputCardViews];
    [self updateUI];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    [self initCardMathingGameAndCardViews];
    [self reputCardViews];
    [self updateUI];
}

- (void)updateUI
{
    for (int i = 0; i < [self.cardMathingGame cardsCount]; i++) {
        CardView *cardView = (CardView *)self.allCardsView.subviews[i];
        cardView.card = [self.cardMathingGame cardAtIndex:i];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.cardMathingGame.score];
}

- (void)reputCardViews
{
    for (int i = 0; i < [self.allCardsView.subviews count]; i++) {
        int row = i / self.cardsGrid.columnCount;
        int column = i % self.cardsGrid.columnCount;
        CardView *cardView = (CardView *)self.allCardsView.subviews[i];
        [UIView animateWithDuration:1.0
                         animations:^{
                             cardView.frame = [self.cardsGrid frameOfCellAtRow:row inColumn:column];
                         }];
 //       cardView.frame = [self.cardsGrid frameOfCellAtRow:row inColumn:column];
    }
    [self.allCardsView setNeedsDisplay];
}

@end
