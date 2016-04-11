//
//  FirstViewController.h
//  frank
//
//  Created by Leonardo Formaggio on 4/11/16.
//  Copyright © 2016 Westfield. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end
