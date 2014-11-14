//
//  MHBasicGalleryItem.h
//  MHVideoPhotoGallery
//
//  Created by Adlai Holler on 11/13/14.
//  Copyright (c) 2014 Mario Hahn. All rights reserved.
//

#import "MHGalleryItem.h"

/**
 Manually-controllable gallery item. You can either set an image, or set a block for getting an image.
 */
@interface MHBasicGalleryItem : MHGalleryItem

/**
 A block that will load the image asynchronously when executed. In this block, for example, you could request an image from a PHImageManager.
 @param completionHandler Execute this block when the fetch is completed
 */
@property (nonatomic, strong) void(^loadImage)(MHImageType imageType, MHGalleryItemLoadImageCompletionHandler completionHandler);

- (void)setLoadImageWithThumbnailLoader:(void(^)(MHGalleryItemLoadImageCompletionHandler completionHandler))thumbnailLoader fullLoader:(void(^)(MHGalleryItemLoadImageCompletionHandler completionHandler))fullLoader;

// if not nil, -loadImage will simply pass this into the completion handler
@property (nonatomic, strong) UIImage *image;
// if not nil, -loadImage will simply pass this into the completion handler
@property (nonatomic, strong) UIImage *thumbnailImage;
@end
