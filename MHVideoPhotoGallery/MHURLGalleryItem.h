//
//  MHURLGalleryItem.h
//  MHVideoPhotoGallery
//
//  Created by Adlai Holler on 11/13/14.
//  Copyright (c) 2014 Mario Hahn. All rights reserved.
//

#import "MHGalleryItem.h"
#import "SDWebImageDownloader.h"

typedef NS_ENUM(NSInteger, MHURLType) {
    MHURLDefault = 0,
    MHURLVimeo,
    MHURLYouTube
};

@interface MHURLGalleryItem : MHGalleryItem
+ (instancetype)itemWithURL:(NSURL *)url galleryType:(MHGalleryType)galleryType context:(NSString *)contextOrNil;
+ (instancetype)itemWithURL:(NSURL *)url galleryType:(MHGalleryType)galleryType;
+ (instancetype)itemWithYoutubeVideoID:(NSString *)videoID context:(NSString *)context;
+ (instancetype)itemWithVimeoVideoID:(NSString *)videoID context:(NSString *)context;

@property (nonatomic, readonly) MHURLType urlType;
@property (nonatomic, strong, readonly) NSURL *url;
@property (nonatomic, strong) NSURL *thumbnailURL;
@property (nonatomic) SDWebImageDownloaderOptions options;

@end
