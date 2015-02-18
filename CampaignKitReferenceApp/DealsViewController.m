//
//  DealsViewController.m
//  CKReferenceApp
//
//  Created by Scott Yoder on 7/15/14.
//  Copyright (c) 2014 Radius Networks. All rights reserved.
//

#import "DealsViewController.h"
#import "AppDelegate.h"
#import "CKCampaignTableViewCell.h"

@interface DealsViewController ()
@end

@implementation DealsViewController {
    NSMutableArray* campaigns;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped:)];
    self.navigationItem.leftBarButtonItem = done;
    
    [self copyCampaigns];
    [self.tableView setContentInset:UIEdgeInsetsMake(2,0,50,0)];

  
    UIImageView *bg = [[UIImageView alloc] initWithImage:[self blur:[UIImage imageNamed:@"cafe-bg.png"]]];
    [self.tableView setBackgroundView:bg];
    [self setNeedsStatusBarAppearanceUpdate];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) copyCampaigns
{
    AppDelegate *appDelegate = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    campaigns = [appDelegate.campaignKitManager.campaigns mutableCopy];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self copyCampaigns];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    //[self setCellzPositions];
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
    return campaigns.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealCell" forIndexPath:indexPath];
    CKCampaignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealCell" forIndexPath:indexPath];
    
    // Configure the cell...
    CKCampaign* campaign = campaigns[indexPath.row];
    //cell.textLabel.text = campaign.title;
    //cell.detailTextLabel.text = campaign.message;

    NSURL* url = [[NSURL alloc] initWithString:@""];
    [cell.webView loadHTMLString:campaign.content.body baseURL: url];
    // prevent scrolling in the webview
    cell.webView.scrollView.scrollEnabled = NO;
    cell.webView.scrollView.bounces = NO;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CKCampaign* campaign = campaigns[indexPath.row];
    NSString* url = campaign.content.attributes[@"on_click_url"];
    if (url) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

-(void) setCellzPositions
{
    NSArray *sortedIndexPaths = [[self.tableView indexPathsForVisibleRows] sortedArrayUsingSelector:@selector(compare:)];
    for (NSIndexPath *path in sortedIndexPaths) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
        cell.layer.zPosition = path.row;
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return true;
    //return indexPath.row == 0;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        CKCampaign* campaign = campaigns[indexPath.row];
        [campaigns removeObjectAtIndex:indexPath.row];
        AppDelegate *appDelegate = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
        [appDelegate.campaignKitManager removeCampaign:campaign];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//}


- (void)doneButtonTapped:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)showCampaign:(CKCampaign*)campaign
{
    //[self copyCampaigns];
    NSIndexPath* top = [NSIndexPath indexPathForRow:0 inSection:0];
    NSInteger index = [campaigns indexOfObject:campaign];
    if (index == NSNotFound)
    {
        [campaigns insertObject:campaign atIndex:0];
        [self.tableView insertRowsAtIndexPaths:@[top] withRowAnimation:UITableViewRowAnimationBottom];
        [self.tableView selectRowAtIndexPath:top animated:YES scrollPosition:UITableViewScrollPositionTop];
    } else {
        [campaigns removeObjectAtIndex:index];
        [campaigns insertObject:campaign atIndex:0];
        NSIndexPath* oldIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.tableView moveRowAtIndexPath:oldIndexPath toIndexPath:top];
        [self.tableView selectRowAtIndexPath:top animated:YES scrollPosition:UITableViewScrollPositionTop];
    }

    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    [self setCellzPositions];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (UIImage*) blur:(UIImage*)theImage
{
    // create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    
    // setting up Gaussian Blur (we could use one of many filters offered by Core Image)
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:25.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];//create a UIImage for this function to "return" so that ARC can manage the memory of the blur... ARC can't manage CGImageRefs so we need to release it before this function "returns" and ends.
    CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
    
    return returnImage;
}

@end
