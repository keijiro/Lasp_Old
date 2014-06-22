// Lasp - Low-latency Audio Stream Plugin for Unity
// By Keijiro Takahashi, 2014
// https://github.com/keijiro/Lasp

#import "AudioInputHandler.h"
#import "AudioRingBuffer.h"

static BOOL initialized = NO;

void LaspInitialize()
{
    if (!initialized)
    {
        [AudioInputHandler.sharedInstance start];
        initialized = YES;
    }
}

uint32_t LaspCountInputChannels()
{
    return (uint32_t)AudioInputHandler.sharedInstance.ringBuffers.count;
}

void LaspRetrieveWaveform(uint32_t sourceChannel, float *buffer, uint32_t bufferLength, uint32_t channelCount)
{
    NSArray *ringBuffers = AudioInputHandler.sharedInstance.ringBuffers;
    AudioRingBuffer *source = [ringBuffers objectAtIndex:(sourceChannel % ringBuffers.count)];
    [source retrieveSamples:buffer count:(bufferLength / channelCount) stride:channelCount];
}
