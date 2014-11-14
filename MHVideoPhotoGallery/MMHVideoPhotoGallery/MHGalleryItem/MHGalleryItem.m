//
//  MHGalleryItem.m
//  MHVideoPhotoGallery
//
//  Created by Mario Hahn on 01.04.14.
//  Copyright (c) 2014 Mario Hahn. All rights reserved.
//  Heavily modified by Adlai Holler. Modifications are Copyright (c) 2014 Adlai Holler.

#import "MHGalleryItem.h"
#import "MHGalleryItem-Subclass.h"

static BOOL MHGalleryItemRegistrationEnabled = YES;

@implementation MHGalleryItem

+ (BOOL)registrationEnabled {
    return MHGalleryItemRegistrationEnabled;
}

+ (void)setRegistrationEnabled:(BOOL)enabled {
    MHGalleryItemRegistrationEnabled = enabled;
}

+ (instancetype)itemWithIdentifier:(NSString *)identifier type:(MHGalleryType)galleryType context:(NSString *)context {
    return [self itemWithIdentifier:identifier type:galleryType context:context awaken:nil];
}

+ (NSMapTable *)registryForContext:(NSString *)context {
    if (context == nil) {
        context = @"MHGalleryItemContextDefault";
    }
    
    static NSMutableDictionary *registry;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        registry = [NSMutableDictionary new];
    });
    NSMapTable *result = registry[context];
    if (result == nil) {
        result = [NSMapTable strongToWeakObjectsMapTable];
        registry[context] = result;
    }
    return result;
}

+ (instancetype)itemWithIdentifier:(NSString *)identifier type:(MHGalleryType)galleryType context:(NSString *)context awaken:(void (^)(id self))awakenBlock {
    if (!self.registrationEnabled) {
        id result = [[self alloc] initWithIdentifier:identifier type:galleryType];
        if (awakenBlock != nil) {
            awakenBlock(result);
        }
    }

    NSMapTable *registry = [self registryForContext:context];

    MHGalleryItem *result = [registry objectForKey:identifier];
    if (result == nil) {
        result = [[self alloc] initWithIdentifier:identifier type:galleryType];
        if (awakenBlock != nil) {
            awakenBlock(result);
        }
        [registry setObject:result forKey:identifier];
    }
    return result;
}

- (instancetype)initWithIdentifier:(NSString *)identifier type:(MHGalleryType)galleryType {
    self = [super init];
    if (!self) { return nil; }
    _identifier = [identifier copy];
    _galleryType = galleryType;
    return self;
}

- (void)loadImageWithType:(MHImageType)imageType completionHandler:(MHGalleryItemLoadImageCompletionHandler)completionHandler {
    NSAssert(NO, @"Base class MHGalleryItem does not implement %s", __PRETTY_FUNCTION__);
}

- (void)loadVideoWithCompletionHandler:(MHGalleryItemLoadVideoCompletionHandler)completionHandler {
    NSAssert(NO, @"Base class MHGalleryItem does not implement %s", __PRETTY_FUNCTION__);    
}
@end

