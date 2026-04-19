#import <Cocoa/Cocoa.h>

@interface LGDefaultsBridge : NSObject

+ (NSString *)defaultEndpointURL;
+ (void)setDefaultEndpointURL:(NSString *)value;

@end

