//
//  BNRHypnosisView.m
//  Hypnosister2
//
//  Created by Leksha Ramdenee on 2016-10-07.
//  Copyright © 2016 Leksha Ramdenee. All rights reserved.
//

#import "BNRHypnosisView.h"

@interface BNRHypnosisView ()

@property (nonatomic, strong) UIColor *circleColor;

@end

@implementation BNRHypnosisView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // All BNRHypnosisViews start with a clear background color
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
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
    [self.circleColor setStroke];
    
    // Draw the line
    [path stroke];
   
    // Add Shadow
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(UIGraphicsGetCurrentContext());
    CGContextSetShadow(currentContext, CGSizeMake(4, 9), 5);

    UIImage *logoImage = [UIImage imageNamed:@"appleLogo.png"];
    NSLog(@"Image: %@", NSStringFromCGSize(logoImage.size));
    CGSize newImageSize = CGSizeMake(logoImage.size.width/12, logoImage.size.height/12);
    NSLog(@"New size: %@", NSStringFromCGSize(logoImage.size));
    NSLog(@"View Size: %@", NSStringFromCGRect(self.bounds));
    CGRect imagePosition = CGRectMake(center.x - newImageSize.width/2,
                                      center.y - newImageSize.height/2,
                                      newImageSize.width,
                                      newImageSize.height);
    NSLog(@"ImagePosition: %@", NSStringFromCGRect(imagePosition));
    [logoImage drawInRect:imagePosition];
    
    // Reset current state
    CGContextRestoreGState(currentContext);
}

// When a finger touches the screen
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@ was touched", self);
    
    // get 3 random numbers between 0 and 1
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = randomColor;
}

- (void)setCircleColor:(UIColor *)circleColor {
    _circleColor = circleColor;
    [self setNeedsDisplay];
}
@end
