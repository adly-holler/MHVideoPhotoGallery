//
//  ExampleViewControllerTableView.m
//  MHVideoPhotoGallery
//
//  Created by Mario Hahn on 14.01.14.
//  Copyright (c) 2014 Mario Hahn. All rights reserved.
//

#import "ExampleViewControllerTableView.h"
#import "MHOverviewController.h"
#import "UIImageView+WebCache.h"
#import "MHURLGalleryItem.h"

@implementation ImageTableViewCell

@end

@interface ExampleViewControllerTableView ()
@property(nonatomic,strong) NSArray *galleryDataSource;
@end

@implementation ExampleViewControllerTableView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"TableView";
    
    
    MHURLGalleryItem *youtube = [MHURLGalleryItem itemWithURL:[NSURL URLWithString:@"http://www.youtube.com/watch?v=YSdJtNen-EA"]
                                                   galleryType:MHGalleryTypeVideo];
    
    MHURLGalleryItem *vimeo0 = [MHURLGalleryItem itemWithURL:[NSURL URLWithString:@"http://vimeo.com/35515926"]
                                                  galleryType:MHGalleryTypeVideo];
    MHURLGalleryItem *vimeo1 = [MHURLGalleryItem itemWithURL:[NSURL URLWithString:@"http://vimeo.com/50006726"]
                                                  galleryType:MHGalleryTypeVideo];
    MHURLGalleryItem *vimeo3 = [MHURLGalleryItem itemWithURL:[NSURL URLWithString:@"http://vimeo.com/66841007"]
                                                  galleryType:MHGalleryTypeVideo];
    
    MHURLGalleryItem *landschaft = [MHURLGalleryItem itemWithURL:[NSURL URLWithString:@"http://alles-bilder.de/landschaften/HD%20Landschaftsbilder%20(47).jpg"]
                                                      galleryType:MHGalleryTypeImage];
    
    MHURLGalleryItem *landschaft1 = [MHURLGalleryItem itemWithURL:[NSURL URLWithString:@"http://de.flash-screen.com/free-wallpaper/bezaubernde-landschaftsabbildung-hd/hd-bezaubernde-landschaftsder-tapete,1920x1200,56420.jpg"]
                                                       galleryType:MHGalleryTypeImage];
    
    MHURLGalleryItem *landschaft2 = [MHURLGalleryItem itemWithURL:[NSURL URLWithString:@"http://alles-bilder.de/landschaften/HD%20Landschaftsbilder%20(64).jpg"]
                                                       galleryType:MHGalleryTypeImage];
    
    MHURLGalleryItem *landschaft3 = [MHURLGalleryItem itemWithURL:[NSURL URLWithString:@"http://www.dirks-computerseite.de/wp-content/uploads/2013/06/purpleworld1.jpg"]
                                                       galleryType:MHGalleryTypeImage];
    
    MHURLGalleryItem *landschaft4 = [MHURLGalleryItem itemWithURL:[NSURL URLWithString:@"http://alles-bilder.de/landschaften/HD%20Landschaftsbilder%20(42).jpg"]
                                                       galleryType:MHGalleryTypeImage];
    
    MHURLGalleryItem *landschaft5 = [MHURLGalleryItem itemWithURL:[NSURL URLWithString:@"http://woxx.de/wp-content/uploads/sites/3/2013/02/8X2cWV3.jpg"]
                                                       galleryType:MHGalleryTypeImage];
    
    MHURLGalleryItem *landschaft6 = [MHURLGalleryItem itemWithURL:[NSURL URLWithString:@"http://kwerfeldein.de/wp-content/uploads/2012/05/Sharpened-version.jpg"]
                                                       galleryType:MHGalleryTypeImage];
    
    MHURLGalleryItem *landschaft7 = [MHURLGalleryItem itemWithURL:[NSURL URLWithString:@"http://eswalls.com/wp-content/uploads/2014/01/sunset-glow-trees-beautiful-scenery.jpg"]
                                                       galleryType:MHGalleryTypeImage];
    
    MHURLGalleryItem *landschaft8 = [MHURLGalleryItem itemWithURL:[NSURL URLWithString:@"http://eswalls.com/wp-content/uploads/2014/01/beautiful_scenery_wallpaper_The_Eiffel_Tower_at_night_.jpg"]
                                                       galleryType:MHGalleryTypeImage];
    
    MHURLGalleryItem *landschaft9 = [MHURLGalleryItem itemWithURL:[NSURL URLWithString:@"http://p1.pichost.me/i/40/1638707.jpg"]
                                                       galleryType:MHGalleryTypeImage];
    
    MHURLGalleryItem *landschaft10 = [MHURLGalleryItem itemWithURL:[NSURL URLWithString:@"http://4.bp.blogspot.com/-8O0ZkAgb6Bo/Ulf_80tUN6I/AAAAAAAAH34/I1L2lKjzE9M/s1600/Beautiful-Scenery-Wallpapers.jpg"]
                                                        galleryType:MHGalleryTypeImage];
    
    
    
    self.galleryDataSource = @[landschaft,landschaft1,landschaft2,landschaft3,landschaft4,landschaft5,vimeo0,vimeo1,vimeo3,landschaft6,landschaft7,youtube,landschaft8,landschaft9,landschaft10];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = nil;
    cellIdentifier = @"ImageTableViewCell";
    
    ImageTableViewCell *cell = (ImageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell){
        cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    MHURLGalleryItem *item = self.galleryDataSource[indexPath.row];
    [cell.iv setImageForMHGalleryItem:item imageType:MHImageTypeFull successBlock:nil];
    
    cell.labelText.text = item.descriptionString;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImageView *imageView = [(ImageTableViewCell*)[tableView cellForRowAtIndexPath:indexPath] iv];
    
    NSArray *galleryData = self.galleryDataSource;
    
    
    MHGalleryController *gallery = [[MHGalleryController alloc] initWithPresentationStyle:MHGalleryViewModeImageViewerNavigationBarShown];
    gallery.galleryItems = galleryData;
    gallery.presentingFromImageView = imageView;
    gallery.presentationIndex = indexPath.row;
    
    __weak MHGalleryController *blockGallery = gallery;
    
    gallery.finishedCallback = ^(NSUInteger currentIndex,UIImage *image,MHTransitionDismissMHGallery *interactiveTransition,MHGalleryViewMode viewMode){
        
        NSIndexPath *newIndex = [NSIndexPath indexPathForRow:currentIndex inSection:0];
        
        [self.tableView scrollToRowAtIndexPath:newIndex atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView = [(ImageTableViewCell*)[self.tableView cellForRowAtIndexPath:newIndex] iv];
            [blockGallery dismissViewControllerAnimated:YES dismissImageView:imageView completion:nil];
        });
        
    };
    
    [self presentMHGalleryController:gallery animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.galleryDataSource.count;
}


@end
