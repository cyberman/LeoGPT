#import "LGDefaultsBridge.h"

@implementation LGDefaultsBridge

+ (NSString *)defaultEndpointURL
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"DefaultEndpointURL"];
}

+ (void)setDefaultEndpointURL:(NSString *)value
{
    NSUserDefaults *defaults;

    defaults = [NSUserDefaults standardUserDefaults];

    if (value != nil) {
        [defaults setObject:value forKey:@"DefaultEndpointURL"];
    } else {
        [defaults removeObjectForKey:@"DefaultEndpointURL"];
    }
}

@end

