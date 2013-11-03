//
//  CustomAnnotation.h
//  DemoLugares
//
//  Created by Backbeam Prototypr on 10/2/2013.
//  Copyright (c) 2013 uclm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotation : NSObject <MKAnnotation> {
    
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, strong) id object; // a reference to the data model

@end
