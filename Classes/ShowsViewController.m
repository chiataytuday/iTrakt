#import "ShowsViewController.h"
#import "ShowTableViewCell.h"
#import "ShowDetailsViewController.h"

#import "Trakt.h"
#import "Show.h"

#define ROW_HEIGHT 66.0

@implementation ShowsViewController

@synthesize shows;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.rowHeight = ROW_HEIGHT;
  // TODO replace this with the actual username
  [Trakt sharedInstance].apiUser = @"matsimitsu";
}


- (void)reloadTableViewData {
  [self.tableView reloadData];
  [self loadImagesForVisibleCells];
}


- (void)loadImageForCell:(UITableViewCell *)cell {
  ShowTableViewCell *showCell = (ShowTableViewCell *)cell;
  [showCell.show ensurePosterIsLoaded:^{
    // this callback is only run if the image has to be downloaded first
    [showCell setNeedsLayout];
  }];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.shows count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";

  ShowTableViewCell *cell = (ShowTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[ShowTableViewCell alloc] initWithReuseIdentifier:CellIdentifier] autorelease];
  }

  cell.show = [self.shows objectAtIndex:indexPath.row];

  return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  Show *show = [self.shows objectAtIndex:indexPath.row];
  ShowDetailsViewController *controller = [[ShowDetailsViewController alloc] initWithShow:show];
  [self.navigationController pushViewController:controller animated:YES];
  [controller release];
}


#pragma mark -
#pragma mark UIScrollViewDelegate methods


- (void)loadImagesForVisibleCells {
  NSArray *cells = [self.tableView visibleCells];
  for (int i = 0; i < [cells count]; i++) {
    [self loadImageForCell:[cells objectAtIndex:i]];
  }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  [self loadImagesForVisibleCells];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if (!decelerate) {
    [self loadImagesForVisibleCells];
  }
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end


