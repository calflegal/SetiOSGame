//
//  SetCard.h
//  SetGame
//
//  Created by H Calvin Flegal on 8/1/13.
//  Copyright (c) 2013 H Calvin Flegal. All rights reserved.
//

#import "Card.h"


@interface SetCard : Card

@property(nonatomic,strong) NSString* shape;
@property(nonatomic)NSString* texture;
@property(nonatomic)UIColor* color;
@property(nonatomic)NSUInteger count;

+(NSArray *)validColors;
+(NSArray*)validTextures;
+(NSArray *)validShapes;
+(NSUInteger)maxCount;

@end
