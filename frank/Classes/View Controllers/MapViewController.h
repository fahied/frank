//
//  MapViewController.h
//  frank
//
//  Created by Leonardo Formaggio on 4/11/16.
//  Copyright © 2016 Westfield. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@end
