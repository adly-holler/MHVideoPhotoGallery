//
//  MHLegacyAssetGalleryItem.m
//  MHVideoPhotoGallery
//
//  Created by Adlai Holler on 11/14/14.
//  Copyright (c) 2014 Mario Hahn. All rights reserved.
//

#import "MHLegacyAssetGalleryItem.h"
#import "MHGalleryItem-Subclass.h"

@implementation MHLegacyAssetGalleryItem

+ (instancetype)itemWithAsset:(ALAsset *)asset context:(NSString *)contextOrNil {
    NSString *identifier = [[asset valueForProperty:ALAssetPropertyAssetURL] absoluteString];
    MHGalleryType type = MHGalleryTypeImage;
    if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {
        type = MHGalleryTypeVideo;
    }
    MHLegacyAssetGalleryItem *item = [self itemWithIdentifier:identifier type:type context:contextOrNil awaken:^(id self) {
        [self awakeWithAsset:asset];
    }];
    return item;
}

- (void)awakeWithAsset:(ALAsset *)asset {
    _asset = asset;
}

- (void)loadImageWithType:(MHImageType)imageType completionHandler:(MHGalleryItemLoadImageCompletionHandler)completionHandler {
    MHAssetImageType type = MHAssetImageTypeFull;
    if (imageType == MHImageTypeThumb) {
        type = MHAssetImageTypeThumb;
    }
    
    [MHGallerySharedManager.sharedManager getImageFromAssetLibrary:[self.asset valueForProperty:ALAssetPropertyAssetURL] assetType:type successBlock:^(UIImage *image, NSError *error) {
        completionHandler(image, error);
    }];
}

- (void)loadVideoWithCompletionHandler:(MHGalleryItemLoadVideoCompletionHandler)completionHandler {
    NSAssert(NO, @"Loading images from legacy assets is not supported");
}

@end
