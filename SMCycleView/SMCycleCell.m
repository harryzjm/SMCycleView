//
//  SMCycleCell.m
//  SMCycleView
//
//  Created by Magic on 23/2/2016.
//  Copyright © 2016 Magic. All rights reserved.
//

#import "SMCycleCell.h"
#import <Masonry/Masonry.h>

@implementation SMCycleCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:imageView];
        
        _imageView = imageView;
    }
    return _imageView;
}

@end
