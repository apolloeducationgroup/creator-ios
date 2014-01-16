
#import "EncodeObject.h"

@implementation EncodeObject

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}

+ (void) encode : (NSString*) fileName : (NSString*) keyName : (id) encodeObject
{
    //////// ////NSLog@"Coming to Encode");
    NSMutableData *mutadata = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutadata];
    [archiver encodeObject:encodeObject forKey:keyName];
    [archiver finishEncoding];
    [mutadata writeToFile:fileName atomically:YES];
}

@end