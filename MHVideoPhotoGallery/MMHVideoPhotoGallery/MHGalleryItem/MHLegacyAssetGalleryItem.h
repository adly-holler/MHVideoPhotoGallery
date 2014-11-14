//
//  MHLegacyAssetGalleryItem.h
//  MHVideoPhotoGallery
//
//  Created by Adlai Holler on 11/14/14.
//  Copyright (c) 2014 Mario Hahn. All rights reserved.
//

#import "MHGalleryItem.h"
@import AssetsLibrary;

@interface MHLegacyAssetGalleryItem : MHGalleryItem

+ (instancetype)itemWithAsset:(ALAsset *)asset context:(NSString *)contextOrNil;
@property (nonatomic, strong, readonly) ALAsset *asset;

@end
