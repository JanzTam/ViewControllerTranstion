//
//  ViewController.m
//  MagicMoving
//
//  Created by tangjianzhuo on 16/3/24.
//  Copyright © 2016年 QuanFu. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "MoveTranstion.h"

@interface ViewController ()<UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;//不能放在viewDidLoad里，保证每次当前VC出现的时候delegate = self
}

#pragma mark - tableView-delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell * cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectCell = (TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - other
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detail"]) {
        DetailViewController * detailVC = (DetailViewController *)segue.destinationViewController;
        detailVC.image = self.selectCell.picImageView.image;
    }
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if ([toVC isKindOfClass:[DetailViewController class]]) {
        MoveTranstion * transition = [[MoveTranstion alloc] init];
        return transition;
    }
    return nil;
}

@end
