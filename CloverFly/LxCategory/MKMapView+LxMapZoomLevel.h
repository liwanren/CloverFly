//
//  MKMapView+LxMapZoomLevel.h
/*
 //     ___ __   ____  _   _________
 //   / __// /  / __ \| | / / __/ _ \
 //  / /  / /_ / /_/ /| |/ / _// , _/
 // /___//____/\____/_\___/___/_/|_|
 // --------Created by clover--------
 */


#import <MapKit/MapKit.h>

/**
 #define GEORGIA_TECH_LATITUDE 33.777328
 #define GEORGIA_TECH_LONGITUDE -84.397348
 
 use
 CLLocationCoordinate2D centerCoord = { GEORGIA_TECH_LATITUDE, GEORGIA_TECH_LONGITUDE };
 [mapView setCenterCoordinate:centerCoord zoomLevel:ZOOM_LEVEL animated:NO];
 */

@interface MKMapView (LxMapZoomLevel)
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;
@end
