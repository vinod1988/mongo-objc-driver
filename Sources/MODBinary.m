//
//  MODBinary.m
//  mongo-objc-driver
//
//  Created by Jérôme Lebel on 28/09/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MOD_internal.h"
#import "NSData+Base64.h"

@implementation MODBinary

@synthesize data = _data, binaryType = _binaryType;

- (id)initWithData:(NSData *)data binaryType:(char)binaryType
{
    return [self initWithBytes:[data bytes] length:[data length] binaryType:binaryType];
}

- (id)initWithBytes:(const void *)bytes length:(NSUInteger)length binaryType:(char)binaryType
{
    if (self = [self init]) {
        _data = [[NSData alloc] initWithBytes:bytes length:length];
        _binaryType = binaryType;
    }
    return self;
}

- (NSString *)jsonValueWithPretty:(BOOL)pretty strictJSON:(BOOL)strictJSON
{
    NSString *result;
    
    if (pretty) {
        result = [NSString stringWithFormat:@"{ \"$binary\" : \"%@\", \"$type\" : \"%d\" }", [_data base64String], (int)_binaryType];
    } else {
        result = [NSString stringWithFormat:@"{\"$binary\":\"%@\",\"$type\":\"%d\"}", [_data base64String], (int)_binaryType];
    }
    return result;
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]]) {
        return [[object data] isEqual:_data] && [object binaryType] == _binaryType;
    }
    return NO;
}

@end
