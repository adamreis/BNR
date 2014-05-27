//
//  AHRHypnosisView.m
//  Hypnosister
//
//  Created by Adam Reis on 5/26/14.
//  Copyright (c) 2014 Adam Reis. All rights reserved.
//

#import "AHRHypnosisView.h"

@implementation AHRHypnosisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    path.lineWidth = 10;
    
    float radius = (hypot(bounds.size.width, bounds.size.height) / 2.0);
    while (radius > 0) {
        [path moveToPoint:CGPointMake(center.x + radius, center.y)];
        [path addArcWithCenter:center
                        radius:radius
                    startAngle:0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
        radius -= 20;
    }
    
    
    

    [path stroke];
    
}


@end
