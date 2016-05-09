//
//  SMCycleView.h
//  SMCycleView
//
//  Created by Magic on 23/2/2016.
//  Copyright © 2016 Magic. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SMCycleView;

@protocol SMCycleViewDelegate <NSObject>

@optional
- (void)cycleView:(SMCycleView *)cycleView didSelectItemAtIndex:(NSInteger)index;

@end

@interface SMCycleView : UIView

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, copy) NSArray<UIImage *> *imageGroup;

@property (nonatomic, weak) id<SMCycleViewDelegate> delegate;

+ (instancetype)cycleViewWithImageGroup:(NSArray *)group;

@end
