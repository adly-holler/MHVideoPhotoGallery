//
//  MHURLGalleryItem.m
//  MHVideoPhotoGallery
//
//  Created by Adlai Holler on 11/13/14.
//  Copyright (c) 2014 Mario Hahn. All rights reserved.
//

#import "MHURLGalleryItem.h"
#import "MHGalleryItem-Subclass.h"

@implementation MHURLGalleryItem

+ (instancetype)itemWithURL:(NSURL *)url galleryType:(MHGalleryType)galleryType urlType:(MHURLType)urlType context:(NSString *)contextOrNil {
    MHURLGalleryItem *item = [self itemWithIdentifier:url.absoluteString type:galleryType context:contextOrNil awaken:^(id self) {
        [self awakenWithURL:url type:urlType];
    }];
    NSAssert([item isKindOfClass:self], @"Unexpected item type for %@", item);
    return item;
}

+ (instancetype)itemWithURL:(NSURL *)url galleryType:(MHGalleryType)galleryType context:(NSString *)contextOrNil {
    return [self itemWithURL:url galleryType:galleryType urlType:MHURLDefault context:contextOrNil];
}

+ (instancetype)itemWithURL:(NSURL *)url galleryType:(MHGalleryType)galleryType {
    return [self itemWithURL:url galleryType:galleryType urlType:MHURLDefault context:nil];
}

- (void)awakenWithURL:(NSURL *)url type:(MHURLType)urlType {
    _urlType = urlType;
    _url = url;
    _options = SDWebImageDownloaderContinueInBackground;
    _thumbnailURL = url;
}

+ (instancetype)itemWithVimeoVideoID:(NSString *)videoID context:(NSString *)context {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:MHVimeoBaseURL, videoID]];
    return [self itemWithURL:url galleryType:MHGalleryTypeVideo urlType:MHURLVimeo context:context];
}

+ (instancetype)itemWithYoutubeVideoID:(NSString *)videoID context:(NSString *)context {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:MHYoutubeBaseURL, videoID ]];
    return [self itemWithURL:url galleryType:MHGalleryTypeVideo urlType:MHURLYouTube context:context];
}

- (void)loadImageWithType:(MHImageType)imageType completionHandler:(MHGalleryItemLoadImageCompletionHandler)completionHandler {
    NSURL *url = imageType == MHImageTypeFull ? self.url : self.thumbnailURL;
    [SDWebImageDownloader.sharedDownloader downloadImageWithURL:url options:self.options progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            completionHandler(image, error);
        }];
    }];
}

- (void)loadVideoWithCompletionHandler:(MHGalleryItemLoadVideoCompletionHandler)completionHandler {
    if (self.urlType == MHURLYouTube) {
        [MHGallerySharedManager.sharedManager getYoutubeURLforMediaPlayer:self.url.absoluteString successBlock:^(NSURL *URL, NSError *error) {
            if (error != nil) {
                completionHandler(nil, error);
                return;
            }
            AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:URL];
            completionHandler(item, nil);
        }];
    } else if (self.urlType == MHURLVimeo) {
        [MHGallerySharedManager.sharedManager getVimeoURLforMediaPlayer:self.url.absoluteString successBlock:^(NSURL *URL, NSError *error) {
            if (error != nil) {
                completionHandler(nil, error);
                return;
            }
            AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:URL];
            completionHandler(item, nil);
        }];
    } else {
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:self.url];
        completionHandler(item, nil);
    }
}

@end
