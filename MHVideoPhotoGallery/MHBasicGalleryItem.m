//
//  MHBasicGalleryItem.m
//  MHVideoPhotoGallery
//
//  Created by Adlai Holler on 11/13/14.
//  Copyright (c) 2014 Mario Hahn. All rights reserved.
//

#import "MHBasicGalleryItem.h"

@implementation MHBasicGalleryItem

- (void)loadImageWithType:(MHImageType)imageType completionHandler:(MHGalleryItemLoadImageCompletionHandler)completionHandler {
    if (imageType == MHImageTypeThumb && self.thumbnailImage != nil) {
        completionHandler(self.thumbnailImage, nil);
    } else if (imageType == MHImageTypeFull && self.image != nil) {
        completionHandler(self.image, nil);
    } else {
        NSAssert(self.loadImage != nil, @"request to load image for gallery item %@ but no way to get it.", self);
        self.loadImage(imageType, completionHandler);
    }
}

- (void)setLoadImageWithThumbnailLoader:(void (^)(MHGalleryItemLoadImageCompletionHandler))thumbnailLoader fullLoader:(void (^)(MHGalleryItemLoadImageCompletionHandler))fullLoader {
    self.loadImage = ^(MHImageType imageType, MHGalleryItemLoadImageCompletionHandler completionHandler) {
        if (imageType == MHImageTypeThumb) {
            thumbnailLoader(completionHandler);
        } else {
            fullLoader(completionHandler);
        }
    };
}

@end
