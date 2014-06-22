// Lasp - Low-latency Audio Stream Plugin for Unity
// By Keijiro Takahashi, 2014
// https://github.com/keijiro/Lasp

#import <Foundation/Foundation.h>

@interface AudioRingBuffer : NSObject
{
@private
    Float32 *_samples;
    NSUInteger _offset;
}

- (void)pushSamples:(Float32 *)source count:(NSUInteger)count;
- (void)retrieveSamples:(Float32 *)destination count:(NSUInteger)count stride:(NSUInteger)stride;

@end
