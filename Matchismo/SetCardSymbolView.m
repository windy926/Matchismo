//
//  SetCardSymbolView.m
//  Matchismo
//
//  Created by qsu on 13-12-1.
//  Copyright (c) 2013年 Qi Su. All rights reserved.
//

#import "SetCardSymbolView.h"

@implementation SetCardSymbolView

- (void)setCard:(SetCard *)card
{
    _card = card;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    rect = CGRectInset(self.bounds, 0.1 * self.bounds.size.width, 0.1 * self.bounds.size.height);
    UIBezierPath *path = nil;
    if ([self.card.symbol isEqualToString:@"diamond"]) {
        path = [self diamondPath];
    } else if ([self.card.symbol isEqualToString:@"squiggle"]) {
        path = [self squigglePath];
    } else if ([self.card.symbol isEqualToString:@"oval"]) {
        path = [UIBezierPath bezierPathWithOvalInRect:rect];
    }
    
    [path addClip];
    
    if ([self.card.shading isEqualToString:@"solid"]) {
        [[self colorForSymbol] setFill];
    } else if ([self.card.shading isEqualToString:@"striped"]) {
        CGPoint p1 = CGPointMake(rect.origin.x - 0.5 * rect.size.width, rect.origin.y - 0.5 * rect.size.height);
        CGPoint p2 = CGPointMake(rect.origin.x - 0.4 * rect.size.width, rect.origin.y + 1.5 * rect.size.height);
        float xstep = 0.2 * rect.size.width;
        while (p1.x < rect.origin.x + rect.size.width) {
            [path moveToPoint:p1];
            [path addLineToPoint:p2];
            p1.x += xstep;
            p2.x += xstep;
        }
        [[UIColor whiteColor] setFill];
    } else if ([self.card.shading isEqualToString:@"open"]) {
        [[UIColor whiteColor] setFill];
    }
    [path fill];
    
    [[self colorForSymbol] setStroke];
    path.lineWidth = path.lineWidth * 2;
    [path stroke];
}

- (UIBezierPath *)diamondPath
{
    CGRect rect = CGRectInset(self.bounds, 0.1 * self.bounds.size.width, 0.1 * self.bounds.size.height);
    CGPoint up = CGPointMake(rect.origin.x + 0.5 * rect.size.width, rect.origin.y);
    CGPoint right = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + 0.5 * rect.size.height);
    CGPoint down = CGPointMake(rect.origin.x + 0.5 * rect.size.width, rect.origin.y + rect.size.height);
    CGPoint left = CGPointMake(rect.origin.x, rect.origin.y + 0.5 * rect.size.height);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:up];
    [path addLineToPoint:right];
    [path addLineToPoint:down];
    [path addLineToPoint:left];
    [path closePath];
    
    return path;
}

- (UIBezierPath *)squigglePath
{
    CGRect rect = CGRectInset(self.bounds, 0.2 * self.bounds.size.width, 0.2 * self.bounds.size.height);
    
    float controlPointHeight = 0.25 * rect.size.height;
    float controlPointWidth = 0.5 * rect.size.width;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint now = CGPointMake(rect.origin.x + 0.5 * rect.size.width, rect.origin.y);
    [path moveToPoint:now];
    
    CGPoint next = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
    [path addQuadCurveToPoint:next controlPoint:CGPointMake(0.5 * now.x + 0.5 * next.x, 0.5 * now.y + 0.5 * next.y + controlPointHeight)];
    
    now = next;
    next = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    [path addQuadCurveToPoint:next controlPoint:CGPointMake(0.5 * now.x + 0.5 * next.x + controlPointWidth, 0.8  * now.y + 0.2 * next.y)];
    
    now = next;
    next = CGPointMake(rect.origin.x + 0.5 * rect.size.width, rect.origin.y + rect.size.height);
    [path addQuadCurveToPoint:next controlPoint:CGPointMake(0.5 * now.x + 0.5 * next.x, 0.5 * now.y + 0.5 * next.y + controlPointHeight)];
    
    now = next;
    next = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
    [path addQuadCurveToPoint:next controlPoint:CGPointMake(0.5 * now.x + 0.5 * next.x, 0.5 * now.y + 0.5 * next.y - controlPointHeight)];
    
    now = next;
    next = rect.origin;
    [path addQuadCurveToPoint:next controlPoint:CGPointMake(0.5 * now.x + 0.5 * next.x - controlPointWidth, 0.8  * now.y + 0.2 * next.y)];
    
    now = next;
    next = CGPointMake(rect.origin.x + 0.5 * rect.size.width, rect.origin.y);
    [path addQuadCurveToPoint:next controlPoint:CGPointMake(0.5 * now.x + 0.5 * next.x, 0.5 * now.y + 0.5 * next.y - controlPointHeight)];
    
    [path closePath];
    
    return path;
}

- (UIColor *)colorForSymbol
{
    UIColor *color = nil;
    
    SetCard *card = (SetCard *)self.card;
    if ([card.color isEqualToString:@"red"]) {
        color = [UIColor redColor];
    } else if ([card.color isEqualToString:@"green"]) {
        color = [UIColor greenColor];
    } else if ([card.color isEqualToString:@"purple"]) {
        color = [UIColor purpleColor];
    }
    
    return color;
}

#pragma mark - Initialization

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

@end
