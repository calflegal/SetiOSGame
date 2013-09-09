//
//  FoundSetsController.h
//  Set
//
//  Created by H Calvin Flegal on 9/4/13.
//  Copyright (c) 2013 H Calvin Flegal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCard.h"

@protocol SetCollectionDelegate <NSObject>

@required

//the array of SetCards to display
-(NSArray*)sets;

@end

@interface SetCollectionController :UIViewController <UICollectionViewDataSource,UICollectionViewDelegate>

- (UICollectionViewCell *)collectionView:(UICollectionView *)asker
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;

@property(nonatomic,weak)id <SetCollectionDelegate> delegate;

@end
