//
//  ExampleViewControllerImageView.m
//  MHVideoPhotoGallery
//
//  Created by Mario Hahn on 14.01.14.
//  Copyright (c) 2014 Mario Hahn. All rights reserved.
//

#import "ExampleViewControllerImageView.h"
#import "UIImageView+WebCache.h"
#import "MHURLGalleryItem.h"

@interface ExampleViewControllerImageView ()
@end

@implementation ExampleViewControllerImageView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"ImageView";
    
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
    
    NSArray *galleryItems = @[landschaft,landschaft1,landschaft2,landschaft3,landschaft4,landschaft5,vimeo0,vimeo1,vimeo3,landschaft6,landschaft7,youtube,landschaft8,landschaft9,landschaft10];
    
    __weak ExampleViewControllerImageView *blockSelf = self;

    [self.iv setInseractiveGalleryPresentionWithItems:galleryItems currentImageIndex:0 currentViewController:self finishCallback:^(NSUInteger currentIndex,UIImage *image,MHTransitionDismissMHGallery *interactiveTransition,MHGalleryViewMode viewMode) {
        if (viewMode == MHGalleryViewModeOverView) {
            [blockSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
            blockSelf.iv.image = image;
            blockSelf.iv.currentImageIndex = currentIndex;
            [blockSelf.presentedViewController dismissViewControllerAnimated:YES dismissImageView:blockSelf.iv completion:nil];
        }
    }];
    
    
    [self.iv sd_setImageWithURL:landschaft.url];
    [self.iv setUserInteractionEnabled:YES];
    
    self.iv.shoudlUsePanGestureReconizer = YES;
   
    
}



@end
