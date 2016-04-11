//
//  MapViewController.m
//  frank
//
//  Created by Leonardo Formaggio on 4/11/16.
//  Copyright © 2016 Westfield. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@property (nonatomic) BOOL didUpdateUserLocation;

@end

@implementation MapViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (!self.didUpdateUserLocation) {
        [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
        self.didUpdateUserLocation = YES;
    }
}

@end
