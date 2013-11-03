//
//  PlacesViewController.m
//  DemoLugares
//
//  Created by Backbeam Prototypr on 10/2/2013.
//  Copyright (c) 2013 uclm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Backbeam.h>
#import "PlacesViewController.h"
#import "LBROpinionesViewController.h"

@interface PlacesViewController ()

@property (nonatomic, strong) NSArray *results;

@end

@implementation PlacesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Lugares";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadObjects:YES];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
}

- (void)loadObjects:(BOOL)caching {
    BBQuery* query = [Backbeam queryForEntity:@"places"];
    if (caching) {
        [query setFetchPolicy:BBFetchPolicyLocalAndRemote];
    }
    [query fetch:100 offset:0 success:^(NSArray* objects, NSInteger totalCount, BOOL fromCache) {
        self.results = objects;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    } failure:^(NSError* error) {
        NSLog(@"error %@", [error localizedDescription]);
    }];
}

- (void)refresh:(id)sender {
    [self loadObjects:NO];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"CellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    BBObject* object = self.results[indexPath.row];
    cell.textLabel.text = [object stringForField:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BBObject* object = self.results[indexPath.row];
    
    LBROpinionesViewController *yourNewViewController= [[LBROpinionesViewController alloc] init];
    yourNewViewController.thePlace = object;

    [self.navigationController pushViewController:yourNewViewController animated:YES];
}

@end
