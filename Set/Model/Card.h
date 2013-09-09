//
//  Card.h
//  Machismo
//
//  Created by H Calvin Flegal on 3/18/13.
//  Copyright (c) 2013 H Calvin Flegal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property(nonatomic,strong)NSString* contents;
@property(nonatomic, getter = isFaceUp) BOOL  faceUp;
@property(nonatomic,getter = isUnplayable)BOOL unplayable;


-(int)match:(NSArray*)otherCards;



@end
