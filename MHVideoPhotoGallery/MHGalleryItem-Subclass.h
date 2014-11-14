
@interface MHGalleryItem (Subclassing)

// @param awakenBlock Will only be called if a new item is created, with the new instance being passed in.
+ (instancetype)itemWithIdentifier:(NSString *)identifier type:(MHGalleryType)galleryType context:(NSString *)context awaken:(void(^)(id self))awakenBlock;

@end
