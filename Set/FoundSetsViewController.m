//
//  FoundSetsViewController.m
//  Set
//
//  Created by H Calvin Flegal on 9/5/13.
//  Copyright (c) 2013 H Calvin Flegal. All rights reserved.
//

#import "FoundSetsViewController.h"
#import "CardCollectionViewCell.h"

@interface FoundSetsViewController () 

@end

@implementation FoundSetsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if ([[self.delegate sets] count] == 0) {
        [self.cardCollectionView removeFromSuperview];
    }
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"wood.png"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
