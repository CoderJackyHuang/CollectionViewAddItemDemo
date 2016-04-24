//
//  HYBPhotoItemCell.m
//  CollectionViewAddItemDemo
//
//  Created by huangyibiao on 16/4/24.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBPhotoItemCell.h"
#import "HYBPhotoCell.h"

@interface HYBPhotoItemCell ()

@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UILabel     *nameLabel;

@end

@implementation HYBPhotoItemCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kPhotoItemHeight, kPhotoItemHeight)];
    [self.contentView addSubview:self.photoImageView];
    self.photoImageView.layer.cornerRadius = kPhotoItemHeight / 2;
    self.photoImageView.layer.masksToBounds = YES;
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kPhotoItemHeight, frame.size.width, frame.size.height - kPhotoItemHeight)];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.photoImageView.center = CGPointMake(self.contentView.center.x,
                                             self.photoImageView.center.y);
  }
  
  return self;
}

- (void)setModel:(HYBPhotoItemModel *)model {
  if (_model != model) {
    _model = model;
    
    self.photoImageView.image = model.photo;
    self.nameLabel.text = model.name;
  }
}

@end
