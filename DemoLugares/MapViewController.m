//
//  MapViewController.m
//  DemoLugares
//
//  Created by Backbeam Prototypr on 10/2/2013.
//  Copyright (c) 2013 uclm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Backbeam.h>
#import "MapViewController.h"
#import "CustomAnnotation.h"

@interface MapViewController ()

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Mapa";
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc] init];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.mapView = [[MKMapView alloc] init];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];

    CLLocationDegrees nelat = 54.78664734814606;
    CLLocationDegrees nelon = 13.186666999999943;
    CLLocationDegrees swlat = 25.182908782606656;
    CLLocationDegrees swlon = -14.938333000000057;
    
    CLLocationCoordinate2D maxCoord = CLLocationCoordinate2DMake(MAX(nelat, swlat), MAX(nelon, swlon));
    CLLocationCoordinate2D minCoord = CLLocationCoordinate2DMake(MIN(nelat, swlat), MIN(nelon, swlon));
    
    CLLocationCoordinate2D center   = CLLocationCoordinate2DMake((minCoord.latitude + maxCoord.latitude) / 2.0,
                                                                 (minCoord.longitude + maxCoord.longitude) / 2.0);
    MKCoordinateSpan span = MKCoordinateSpanMake(maxCoord.latitude - minCoord.latitude, maxCoord.longitude - minCoord.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    
    [self.mapView setRegion:region];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    // Calculate the coordinates
    
    CGPoint nePoint = CGPointMake(self.mapView.bounds.origin.x + self.mapView.bounds.size.width, self.mapView.bounds.origin.y);
    CGPoint swPoint = CGPointMake((self.mapView.bounds.origin.x), (self.mapView.bounds.origin.y + self.mapView.bounds.size.height));
    
    // Then transform those point into lat,lng values
    CLLocationCoordinate2D neCoord = [self.mapView convertPoint:nePoint toCoordinateFromView:self.mapView];
    CLLocationCoordinate2D swCoord = [self.mapView convertPoint:swPoint toCoordinateFromView:self.mapView];
    
    CLLocationDegrees swlat = swCoord.latitude;
    CLLocationDegrees swlon = swCoord.longitude;
    CLLocationDegrees nelat = neCoord.latitude;
    CLLocationDegrees nelon = neCoord.longitude;
    
    // Make the query
    
    static NSInteger MAX_LOCATIONS = 300;
    
    BBQuery *query = [Backbeam queryForEntity:@"places"];
    [query bounding:@"location" swlat:swlat swlon:swlon nelat:nelat nelon:nelon limit:MAX_LOCATIONS success:^(NSArray* arr, NSInteger total, BOOL cached) {
        
        NSMutableArray *returned = [[NSMutableArray alloc] initWithArray:arr];
        NSMutableArray *annotationsToRemove = [[NSMutableArray alloc] initWithCapacity:MAX_LOCATIONS];
        NSMutableArray *annotationsToAdd = [[NSMutableArray alloc] initWithCapacity:MAX_LOCATIONS];
        
        for (id<MKAnnotation> annotation in self.mapView.annotations) {
            if ([annotation isKindOfClass:[CustomAnnotation class]]) {
                CustomAnnotation *ann = (CustomAnnotation*) annotation;
                BOOL found = NO;
                for (BBObject *object in arr) {
                    BBObject *otherObject = (BBObject*) ann.object;
                    if ([object.identifier isEqualToString:otherObject.identifier]) {
                        // annotation already visible, do not add result
                        [returned removeObject:object];
                        found = YES;
                        break;
                    }
                }
                if (!found) {
                    // annotation no longer visible
                    [annotationsToRemove addObject:ann];
                }
            }
        }
        [self.mapView removeAnnotations:annotationsToRemove];
        
        // add results not visible yet
        for (BBObject *object in returned) {
            BBLocation *location = [object locationForField:@"location"];
            CustomAnnotation *ann = [[CustomAnnotation alloc] init];
            ann.title = [object stringForField:@"name"];
            ann.coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude);
            ann.object = object;
            [annotationsToAdd addObject:ann];
        }
        
        [self.mapView addAnnotations:annotationsToAdd];
        
    } failure:^(NSError* err) {
        NSLog(@"error %@", err);
    }];
}

@end
