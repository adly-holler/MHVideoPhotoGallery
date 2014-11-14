//
//  MHAssetGalleryItem.h
//  MHVideoPhotoGallery
//
//  Created by Adlai Holler on 11/13/14.
//  Copyright (c) 2014 Mario Hahn. All rights reserved.
//

#import "MHGalleryItem.h"
@import Photos;

@interface MHAssetGalleryItem : MHGalleryItem

/// @param context if present, this string is used to help identify the asset. This way the same asset can be used for two different gallery items with different configurations.
+ (instancetype)itemWithAsset:(PHAsset *)asset context:(NSString *)contextOrNil;


@property (nonatomic, strong, readonly) PHAsset *asset;

// default is PHImageManager.defaultManager
@property (nonatomic, strong) PHImageManager *imageManager;
// default is 1024x1024
@property (nonatomic) CGSize imageSize;
// default is 256x256
@property (nonatomic) CGSize thumbnailSize;
// default is AspectFit
@property (nonatomic) PHImageContentMode contentMode;
// default is AspectFill
@property (nonatomic) PHImageContentMode thumbnailContentMode;
// default is [PHImageRequestOptions new]/[PHVideoRequestOptions new]
@property (nonatomic, strong) PHImageRequestOptions *imageOptions;
@property (nonatomic, strong) PHVideoRequestOptions *videoOptions;
@end
