//
//  HYBPhotoModel.h
//  CollectionViewAddItemDemo
//
//  Created by huangyibiao on 16/4/24.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *	头像模型
 */
@interface HYBPhotoItemModel : NSObject

@property (nonatomic, strong) UIImage *photo;
@property (nonatomic, copy) NSString *name;

@end
