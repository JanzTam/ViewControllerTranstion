//
//  MoveTranstion.m
//  MagicMoving
//
//  Created by tangjianzhuo on 16/3/24.
//  Copyright © 2016年 QuanFu. All rights reserved.
//

#import "MoveTranstion.h"
#import "ViewController.h"
#import "DetailViewController.h"
#import "TableViewCell.h"

@implementation MoveTranstion

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //1.获取动画的源控制器和目标控制器
    ViewController * fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DetailViewController * toVC = (DetailViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView * container = [transitionContext containerView];
    
    //2.创建一个 Cell 中 imageView 的截图，并把 imageView 隐藏，造成使用户以为移动的就是 imageView 的假象
    UIView * snapshotView = [fromVC.selectCell.picImageView snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = [container convertRect:fromVC.selectCell.picImageView.frame fromView:fromVC.selectCell];
    fromVC.selectCell.picImageView.hidden = YES;
    
    //3.设置目标控制器的位置，并把透明度设为0，在后面的动画中慢慢显示出来变为1
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    
    //4.都添加到 container 中。注意顺序不能错了
    [container addSubview:toVC.view];
    [container addSubview:snapshotView];
    
    //5.执行动画
    /*
     这时avatarImageView.frame的值只是跟在IB中一样的，
     如果换成屏幕尺寸不同的模拟器运行时avatarImageView会先移动到IB中的frame,动画结束后才会突然变成正确的frame。
     所以需要在动画执行前执行一次toVC.avatarImageView.layoutIfNeeded() update一次frame
     */
    [toVC.singerPicImageView layoutIfNeeded];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        snapshotView.frame = toVC.singerPicImageView.frame;
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromVC.selectCell.picImageView.hidden = NO;
        toVC.singerPicImageView.image = fromVC.selectCell.picImageView.image;
        toVC.image = fromVC.selectCell.picImageView.image;
        [snapshotView removeFromSuperview];
        
        //一定要记得动画完成后执行此方法，让系统管理 navigation
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
