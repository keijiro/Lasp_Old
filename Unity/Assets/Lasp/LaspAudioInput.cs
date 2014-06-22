using UnityEngine;
using System.Collections;
using System.Runtime.InteropServices;

public class LaspAudioInput : MonoBehaviour
{
    [DllImport ("Lasp")]
    static extern void LaspInitialize();

    [DllImport ("Lasp")]
    static extern uint LaspCountInputChannels();

    [DllImport ("Lasp")]
    static extern void LaspRetrieveWaveform(uint sourceChannel, float[] buffer, uint bufferLength, uint channelCount);

    AudioSource audioSource;

    void Awake()
    {
        LaspInitialize();

        AudioSettings.speakerMode = AudioSpeakerMode.Mono;
        AudioSettings.outputSampleRate = 44100;
        AudioSettings.SetDSPBufferSize(256, 8);

        audioSource = gameObject.AddComponent<AudioSource>();
        audioSource.playOnAwake = false;
        audioSource.clip = AudioClip.Create("(null)", 1024, 1, 44100, false, false);
        audioSource.loop = true;
    }

    void Start()
    {
        audioSource.Play();
    }

    void OnAudioFilterRead(float[] data, int channels)
    {
        LaspRetrieveWaveform(0, data, (uint)data.Length, (uint)channels);
    }
}
