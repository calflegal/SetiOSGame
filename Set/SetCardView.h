//
//  SetCardView.h
//  Set
//
//  Created by H Calvin Flegal on 8/17/13.
//  Copyright (c) 2013 H Calvin Flegal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView
@property(nonatomic)NSUInteger count;
@property(nonatomic,strong)UIColor *color;
@property(nonatomic,strong)NSString* texture;
@property(nonatomic,strong)NSString* shape;
@property(nonatomic)BOOL isSelected;

@end
