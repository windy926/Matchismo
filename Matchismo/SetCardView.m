//
//  SetCardView.m
//  Matchismo
//
//  Created by qsu on 13-11-30.
//  Copyright (c) 2013年 Qi Su. All rights reserved.
//

#import "SetCardView.h"
#import "SetCard.h"
#import "SetCardSymbolView.h"

@implementation SetCardView

- (void)removeFromSuperview
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[SetCardSymbolView class]]) {
            [view removeFromSuperview];
        }
    }
    [super removeFromSuperview];
}

- (void)drawCard
{
    SetCard *card = (SetCard *)self.card;
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         if (card.chosen) {
                             [self setAlpha:0.5];
                         } else {
                             [self setAlpha:1];
                         }
                     }];
    
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    
    CGSize symbolSize = CGSizeMake(0.6 * width, 0.2 * height);
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[SetCardSymbolView class]]) {
            [view removeFromSuperview];
        }
    }
    
    CGRect rect;
    SetCardSymbolView *view;
    switch ([card.number integerValue]) {
        case 1:
            rect = CGRectMake(x + 0.2 * width, y + 0.4 * height, symbolSize.width, symbolSize.height);
            view = [[SetCardSymbolView alloc] initWithFrame:rect];
            view.card = card;
            [self addSubview:view];
            break;
        case 2:
            rect = CGRectMake(x + 0.2 * width, y + 0.25 * height, symbolSize.width, symbolSize.height);
            view = [[SetCardSymbolView alloc] initWithFrame:rect];
            view.card = card;
            [self addSubview:view];
            
            rect = CGRectMake(x + 0.2 * width, y + 0.55 * height, symbolSize.width, symbolSize.height);
            view = [[SetCardSymbolView alloc] initWithFrame:rect];
            view.card = card;
            [self addSubview:view];
            break;
        case 3:
            rect = CGRectMake(x + 0.2 * width, y + 0.18 * height, symbolSize.width, symbolSize.height);
            view = [[SetCardSymbolView alloc] initWithFrame:rect];
            view.card = card;
            [self addSubview:view];

            rect = CGRectMake(x + 0.2 * width, y + 0.4 * height, symbolSize.width, symbolSize.height);
            view = [[SetCardSymbolView alloc] initWithFrame:rect];
            view.card = card;
            [self addSubview:view];

            rect = CGRectMake(x + 0.2 * width, y + 0.62 * height, symbolSize.width, symbolSize.height);
            view = [[SetCardSymbolView alloc] initWithFrame:rect];
            view.card = card;
            [self addSubview:view];

            break;
        
        default:
            break;
    }
    
}

@end
