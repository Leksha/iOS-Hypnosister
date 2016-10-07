//
//  BNRHypnosisView.m
//  Hypnosister2
//
//  Created by Leksha Ramdenee on 2016-10-07.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // All BNRHypnosisViews start with a clear background color
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGRect bounds = self.bounds;
    
    // Figure out the center of the bounds rectangle;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2;
    center.y = bounds.origin.y + bounds.size.height / 2;
    
    // The circle will be the largest that will fit in the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    for (float currentRadius=maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    }

    path.lineWidth = 10;
    [[UIColor lightGrayColor] setStroke];
    // Draw the line
    [path stroke];
}


@end
