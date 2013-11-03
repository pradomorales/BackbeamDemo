//
//  LBROpinionesViewController.m
//  DemoLugares
//
//  Created by Prado Morales on 02/11/13.
//  Copyright (c) 2013 Organization name. All rights reserved.
//

#import "LBROpinionesViewController.h"
#import "LBROpinionCell.h"

@interface LBROpinionesViewController ()

@property (nonatomic, strong) NSArray *opinionsArray;

@end


@implementation LBROpinionesViewController

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
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[LBROpinionCell class] forCellReuseIdentifier:@"OpinionCell"];
    self.view = self.tableView;
    _opinionsArray = [[NSArray alloc] init];
    self.title = [_thePlace stringForField:@"name"];
    
    [self _findOpinionsForPlace];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Number: %d", _opinionsArray.count);
    return _opinionsArray.count;
}

-  (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* identifier = @"CellIdentifier";

    LBROpinionCell* cell = (LBROpinionCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LBROpinionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    BBObject* object = [_opinionsArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = [object stringForField:@"title"];
    cell.messageTextView.text = [object stringForField:@"description"];
    NSDate *creationDate = [object createdAt];
    cell.dateLabel.text = [creationDate description];
    cell.scoreLabel.text = [object stringForField:@"stars"];
    return cell;
}

#pragma mark - Private Methods

- (void)_findOpinionsForPlace
{
    
    BBQuery* query = [Backbeam queryForEntity:@"opinions"];
    [query setQuery:@"where places is ?" withParams:@[_thePlace]];
    [query setFetchPolicy:BBFetchPolicyLocalAndRemote];
    
    [query fetch:100 offset:0 success:^(NSArray* objects, NSInteger totalCount, BOOL fromCache) {
        _opinionsArray = objects;
        [self.tableView reloadData];
        
    } failure:^(NSError* error) {
        NSLog(@"error %@", [error localizedDescription]);
    }];
}

- (IBAction)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
