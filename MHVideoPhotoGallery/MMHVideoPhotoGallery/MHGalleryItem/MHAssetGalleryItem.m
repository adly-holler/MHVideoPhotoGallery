//
//  MHAssetGalleryItem.m
//  MHVideoPhotoGallery
//
//  Created by Adlai Holler on 11/13/14.
//  Copyright (c) 2014 Mario Hahn. All rights reserved.
//

#import "MHAssetGalleryItem.h"
#import "MHGalleryItem-Subclass.h"

static inline MHGalleryType MHGalleryTypeFromPHAssetMediaType(PHAssetMediaType assetMediaType) {
    switch (assetMediaType) {
        case PHAssetMediaTypeImage:
            return MHGalleryTypeImage;
        case PHAssetMediaTypeVideo:
            return MHGalleryTypeVideo;
        default:
            NSCAssert(NO, @"");
        return MHGalleryTypeImage;
    }
};

@implementation MHAssetGalleryItem

+ (instancetype)itemWithAsset:(PHAsset *)asset context:(NSString *)contextOrNil {
    MHAssetGalleryItem *item = [self itemWithIdentifier:asset.localIdentifier type:MHGalleryTypeFromPHAssetMediaType(asset.mediaType) context:contextOrNil awaken:^(MHAssetGalleryItem *self) {
        [self awakeWithAsset:asset];
    }];
    NSAssert([item isKindOfClass:self], @"Unexpected item class for %@", item);
    return item;
}

- (void)awakeWithAsset:(PHAsset *)asset {
    _asset = asset;
    _imageManager = PHImageManager.defaultManager;
    _imageSize = CGSizeMake(1024, 1024);
    _thumbnailSize = CGSizeMake(256, 256);
    _thumbnailContentMode = PHImageContentModeAspectFill;
    _options = self.galleryType == MHGalleryTypeImage ? [PHImageRequestOptions new] : [PHVideoRequestOptions new];
    _contentMode = PHImageContentModeAspectFit;
}

- (void)setOptions:(id)options {
    _options = options;
    Class optionsClass = nil;
    if (self.galleryType == MHGalleryTypeImage) {
        optionsClass = PHImageRequestOptions.class;
    } else {
        optionsClass = PHVideoRequestOptions.class;
    }
    NSAssert([options isKindOfClass:optionsClass], @"");
}

- (void)loadImageWithType:(MHImageType)imageType completionHandler:(MHGalleryItemLoadImageCompletionHandler)completionHandler {
    CGSize imageSize = imageType == MHImageTypeFull ? self.imageSize : self.thumbnailSize;
    PHImageContentMode contentMode = imageType == MHImageTypeFull ? self.contentMode : self.thumbnailContentMode;
    [self.imageManager requestImageForAsset:self.asset targetSize:imageSize contentMode:contentMode options:self.options resultHandler:^(UIImage *result, NSDictionary *info) {
        completionHandler(result, info[PHImageErrorKey]);
    }];
}

- (void)loadVideoWithCompletionHandler:(MHGalleryItemLoadVideoCompletionHandler)completionHandler {
    [self.imageManager requestPlayerItemForVideo:self.asset options:self.options resultHandler:^(AVPlayerItem *playerItem, NSDictionary *info) {
        completionHandler(playerItem, info[PHImageErrorKey]);
    }];
}

@end
