//
//  AHRImageStore.m
//  Homepwner
//
//  Created by Adam Reis on 5/30/14.
//  Copyright (c) 2014 Adam Reis. All rights reserved.
//

#import "AHRImageStore.h"

@interface AHRImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

- (NSString *)imagePathForKey:(NSString *)key;

@end

@implementation AHRImageStore

+ (instancetype)sharedStore
{
    static AHRImageStore *sharedStore = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRImageStore sharedStore]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(clearCache:)
                   name:UIApplicationDidReceiveMemoryWarningNotification
                 object:nil];
    }
    
    return self;
}

- (void)clearCache:(NSNotification *)note
{
    NSLog(@"Flushing %d images out of the cache", [self.dictionary count]);
    [self.dictionary removeAllObjects];
}

- (NSString *)imagePathForKey:(NSString *)key
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:key];
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    self.dictionary[key] = image;
    
    NSString *imagePath = [self imagePathForKey:key];
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    [data writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)key
{
    UIImage *result = self.dictionary[key];
    if (!result) {
        NSString *imagePath = [self imagePathForKey:key];
        
        result = [UIImage imageWithContentsOfFile:imagePath];
        
        if (result) {
            self.dictionary[key] = result;
        } else {
            NSLog(@"Error: unable to find %@", imagePath);
        }
    }
    return result;
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
    
    NSString *imagePath = [self imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}

@end
