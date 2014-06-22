// Lasp - Low-latency Audio Stream Plugin for Unity
// By Keijiro Takahashi, 2014
// https://github.com/keijiro/Lasp

#import <Accelerate/Accelerate.h>
#import "AudioRingBuffer.h"

#pragma mark Configurations

#define kBufferSize (1024 * 16)
#define kBufferByteSize (kBufferSize * sizeof(Float32))

#pragma mark Local utility function

static inline void CopyArray(const Float32 *source, Float32 *destination, NSUInteger length, NSUInteger stride)
{
    if (stride == 1)
        memcpy(destination, source, length * sizeof(Float32));
    else
    {
        for (NSUInteger i = 0; i < length; i++)
        {
            Float32 s = *source++;
            for (NSUInteger c = 0; c < stride; c++)
                *destination++ = s;
        }
    }
}

#pragma mark

@implementation AudioRingBuffer

#pragma mark Constructor / destructor

- (id)init
{
    self = [super init];
    if (self) {
        _samples = malloc(kBufferByteSize);
        memset(_samples, 0, kBufferByteSize);
    }
    return self;
}

- (void)dealloc
{
    free(_samples);
#if ! __has_feature(objc_arc)
    [super dealloc];
#endif
}

#pragma mark Buffer operations

- (void)pushSamples:(Float32 *)source count:(NSUInteger)count
{
    NSUInteger rest = kBufferSize - _offset;
    if (count <= rest) {
        // Simply copy the input data.
        CopyArray(source, _samples + _offset, count, 1);
        _offset += count;
    } else {
        // Split the input data into two parts and copy the each part.
        CopyArray(source, _samples + _offset, rest, 1);
        CopyArray(source + rest, _samples, count - rest, 1);
        _offset = count - rest;
    }
}

- (void)retrieveSamples:(Float32 *)destination count:(NSUInteger)count stride:(NSUInteger)stride
{
    // Take a snapshot of the current state for avoiding race conditions.
    NSUInteger offset = _offset;
    
    // We don't care if the state is going to be changed, because there is enough margin.
    
    if (count <= offset) {
        // Simply process a part of the ring buffer.
        CopyArray(_samples + offset - count, destination, count, stride);
    } else {
        // Process the tail and the head of the ring buffer.
        NSUInteger tail = count - offset;
        // Process the tail and the head of the ring buffer.
        CopyArray(_samples + kBufferSize - tail, destination, tail, stride);
        CopyArray(_samples, destination + tail * stride, offset, stride);
    }
}

@end
