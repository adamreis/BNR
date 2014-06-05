//
//  AHRHypnosisViewController.m
//  HypnoNerd
//
//  Created by Adam Reis on 5/30/14.
//  Copyright (c) 2014 Adam Reis. All rights reserved.
//

#import "AHRHypnosisViewController.h"
#import "AHRHypnosisView.h"

@interface AHRHypnosisViewController () <UITextFieldDelegate>

@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, strong) AHRHypnosisView *hypnoView;

@end

@implementation AHRHypnosisViewController

- (void)loadView
{
    CGRect frame = [UIScreen mainScreen].bounds;
    self.hypnoView = [[AHRHypnosisView alloc] initWithFrame:frame];
    
    CGRect textFieldRect = CGRectMake(40,-50,240,30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me, Kevin";
    textField.returnKeyType = UIReturnKeyDone;

    textField.delegate = self;
    
    [self.hypnoView addSubview:textField];
    self.textField = textField;
    self.view = self.hypnoView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
         usingSpringWithDamping:0.25
          initialSpringVelocity:0.0
                        options:0
                     animations:^{
                         CGRect frame = CGRectMake(40, 40, 240, 30);
                         self.textField.frame = frame;
                     } completion:^(BOOL finished) {
                         NSLog(@"Animation Finished");
                     }];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"HYPNO";
        
        UIImage *hypnoImage = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image = hypnoImage;
    }
    
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self drawHypnoticMessage:textField.text];
    
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

- (void)drawHypnoticMessage:(NSString *)message
{
    for (int i = 0; i < 20; i++) {
        UILabel *messageLabel = [[UILabel alloc] init];
        
        // Configure color and text
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        
        // Resize label to fit text
        [messageLabel sizeToFit];
        
        int width = (int)self.view.bounds.size.width;
        int height = (int)self.view.bounds.size.height;

        
        CGRect frame = messageLabel.frame;
        CGPoint center = self.hypnoView.spiralCenter;
        
        frame.origin = CGPointMake(center.x - frame.size.width / 2.0, center.y -frame.size.height / 2.0);
        messageLabel.frame = frame;
        [self.view insertSubview:messageLabel atIndex:0];

        messageLabel.alpha = 0.0;
        
        [UIView animateWithDuration:0.05
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations: ^{
             messageLabel.alpha = 1.0;
         } completion:NULL];

        
        [UIView animateWithDuration:1.0
                              delay:0.0
             usingSpringWithDamping:0.45
              initialSpringVelocity:0.2
                            options:0
                         animations:^{
                                int x = arc4random() % width;
                                int y = arc4random() % height;
                                messageLabel.center = CGPointMake(x, y);
                         }completion:NULL];
        
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];

        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
        
    }
}

@end
