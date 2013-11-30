//
//  CardView.h
//  Matchismo
//
//  Created by qsu on 13-11-30.
//  Copyright (c) 2013年 Qi Su. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CardView : UIView

@property (strong, nonatomic)Card *card;

- (void)drawCard; // abstract

@end
