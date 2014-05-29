//
//  AHRHypnosisView.m
//  Hypnosister
//
//  Created by Adam Reis on 5/26/14.
//  Copyright (c) 2014 Adam Reis. All rights reserved.
//
//  Based on example code from the Big Nerd Ranch Guide to iOS programming

#import "AHRHypnosisView.h"

@interface AHRHypnosisView ()

@property (nonatomic)  CGPoint spiralCenter;

@end



@implementation AHRHypnosisView

//@synthesize center;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect bounds = self.bounds;
        _spiralCenter.x = bounds.origin.x + bounds.size.width / 2.0;
        _spiralCenter.y = bounds.origin.y + bounds.size.height / 2.0;
        self.backgroundColor = [self randomColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CGRect bounds = self.bounds;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    path.lineWidth = 10;
    
    float radius = (hypot(bounds.size.width, bounds.size.height));
    while (radius > 0) {
        [path moveToPoint:CGPointMake(self.spiralCenter.x + radius, self.spiralCenter.y)];
        [path addArcWithCenter:self.spiralCenter
                        radius:radius
                    startAngle:0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
        radius -= 14;
    }
    

    [path stroke];
}

- (UIColor *)randomColor {
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1.0];
    return randomColor;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    UITouch *myTouch = [[touches allObjects] objectAtIndex: 0];
//    self.spiralCenter = [myTouch locationInView: self];
    
    self.backgroundColor = [self randomColor];
}

- (void)setSpiralCenter:(CGPoint)spiralCenter
{
    _spiralCenter = spiralCenter;
    NSLog(@"_spiralCenter: %f,%f", _spiralCenter.x, _spiralCenter.y);
    [self setNeedsDisplay];
}

@end
