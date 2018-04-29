//
//  ViewController.m
//  Uber Bean
//
//  Created by Colin on 2018-04-27.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

#import "ViewController.h"
#import "NetworkManager.h"
#import "Cafe.h"

@import MapKit;
@import CoreLocation;

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate, NetworkManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSMutableArray *listOfCafes;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NetworkManager *networkManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkManager = [NetworkManager new];
    self.networkManager.delegate = self;
    
    self.locationManager = [CLLocationManager new];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 20;
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestLocation];
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.mapType = MKMapTypeStandard;
    [self.mapView registerClass:[MKMarkerAnnotationView class] forAnnotationViewWithReuseIdentifier:@"cafeAnn"];
}


- (void)setCafes:(NSMutableArray *)cafes {
    self.listOfCafes = [NSMutableArray new];
    self.listOfCafes = cafes;
    [self addMapAnnotations];
}

- (void)addMapAnnotations {
    for (Cafe *cafe in self.listOfCafes) {
        [self.mapView addAnnotation:cafe];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"Authorization status: %d", status);
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [manager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Manager failed: %@", error.localizedDescription);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"Updated locations %@", locations);
    CLLocation *loc = locations[0];
    [self.mapView
     setRegion:MKCoordinateRegionMake(loc.coordinate,
                                      MKCoordinateSpanMake(0.01, 0.01))
     animated:YES];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[Cafe class]]) {
        MKMarkerAnnotationView *mark = (MKMarkerAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"cafeAnn"                                                                              forAnnotation:annotation];
        
        mark.markerTintColor = [UIColor brownColor];
        mark.glyphText = annotation.title;
        mark.titleVisibility = MKFeatureVisibilityVisible;
        mark.animatesWhenAdded = YES;
        
        return mark;
    }
    
    return nil;
}

@end
