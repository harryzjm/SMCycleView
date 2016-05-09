//
//  ViewController.m
//  SMCycleView
//
//  Created by Magic on 23/2/2016.
//  Copyright © 2016 Magic. All rights reserved.
//

#import "ViewController.h"
#import "SMCycleView.h"
#import <Masonry/Masonry.h>

@interface ViewController () <SMCycleViewDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SMCycleView";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil action:nil];
    
    
    NSArray *images = @[[UIImage imageNamed:@"1"],
                        [UIImage imageNamed:@"2"],
                        [UIImage imageNamed:@"3"],
                        [UIImage imageNamed:@"4"]];
    
    
    SMCycleView *v = [SMCycleView cycleViewWithImageGroup:images];
    v.delegate = self;
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@270);
        make.height.equalTo(@180);
        make.center.equalTo(self.view);
    }];
}


#pragma mark - SMCycleViewDelegate

- (void)cycleView:(SMCycleView *)cycleView didSelectItemAtIndex:(NSInteger)index
{
    UIViewController *vc = [UIViewController new];
    vc.title = @"SubviewVC";
    vc.view.backgroundColor = [UIColor colorWithHue:arc4random()%255 / 255.f saturation:1 brightness:1 alpha:1];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
