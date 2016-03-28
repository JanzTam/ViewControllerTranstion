//
//  DetailViewController.m
//  MagicMoving
//
//  Created by tangjianzhuo on 16/3/24.
//  Copyright © 2016年 QuanFu. All rights reserved.
//

#import "DetailViewController.h"
#import "MovePopTranstion.h"
#import "ViewController.h"

@interface DetailViewController ()<UINavigationControllerDelegate>
{
    UIPercentDrivenInteractiveTransition * percentDrivenTransition;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    
    //手势控制转场
    UIScreenEdgePanGestureRecognizer * edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    edgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePan];
}

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)edgePan {
    CGFloat progress = [edgePan translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));//控制百分比范围
    
    if (edgePan.state == UIGestureRecognizerStateBegan) {
        percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (edgePan.state == UIGestureRecognizerStateChanged) {
        [percentDrivenTransition updateInteractiveTransition:progress];
    }
    else if (edgePan.state == UIGestureRecognizerStateCancelled || edgePan.state == UIGestureRecognizerStateEnded) {
        if (progress > 0.5) {
            [percentDrivenTransition finishInteractiveTransition];
        }
        else {
            [percentDrivenTransition cancelInteractiveTransition];
        }
        percentDrivenTransition = nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isKindOfClass:[MovePopTranstion class]]) {
        return percentDrivenTransition;
    }
    else {
        return nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if ([toVC isKindOfClass:[ViewController class]]) {
        return [[MovePopTranstion alloc] init];
    }
    else {
        return nil;
    }
}



@end
