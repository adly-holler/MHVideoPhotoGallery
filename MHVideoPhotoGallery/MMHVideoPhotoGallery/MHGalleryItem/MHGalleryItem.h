//
//  MHGalleryItem.h
//  MHVideoPhotoGallery
//
//  Created by Mario Hahn on 01.04.14.
//  Copyright (c) 2014 Mario Hahn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHGallery.h"

typedef NS_ENUM(NSUInteger, MHGalleryType) {
    MHGalleryTypeImage,
    MHGalleryTypeVideo
};

typedef void(^MHGalleryItemLoadImageCompletionHandler)(UIImage *image, NSError *errorOrNil);
typedef void(^MHGalleryItemLoadVideoCompletionHandler)(AVPlayerItem *playerItem, NSError *errorOrNil);

@interface MHGalleryItem : NSObject

// default is YES
+ (BOOL)registrationEnabled;
+ (void)setRegistrationEnabled:(BOOL)enabled;
// if registration is enabled, and an item with the given identifier exists, that item is returned rather than a new one
// this is the only acceptable method to create a gallery item
+ (instancetype)itemWithIdentifier:(NSString *)identifier type:(MHGalleryType)galleryType context:(NSString *)context;

@property (nonatomic, copy, readonly) NSString *identifier;

// Subclasses should implement this. Default impl calls "loadImage" block.
- (void)loadImageWithType:(MHImageType)imageType completionHandler:(MHGalleryItemLoadImageCompletionHandler)completionHandler;
- (void)loadVideoWithCompletionHandler:(MHGalleryItemLoadVideoCompletionHandler)completionHandler;

/**
 *  Thumbs are automatically generated for Videos. But you can set Thumb Images for GalleryTypeImage.
 */
@property (nonatomic, strong) NSString           *descriptionString;
@property (nonatomic, strong) NSAttributedString *attributedString;
@property (nonatomic, readonly) MHGalleryType       galleryType;

/// default is 0
@property (nonatomic) NSTimeInterval videoDuration;

@end
