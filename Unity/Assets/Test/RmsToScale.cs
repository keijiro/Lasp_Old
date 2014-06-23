using UnityEngine;
using System.Collections;

public class RmsToScale : MonoBehaviour
{
    public bool mute = true;

    const float zeroOffset = 1.5849e-13f;
    const float refLevel = 0.70710678118f; // 1/sqrt(2)
    const float minDB = -60.0f;

    float squareSum;
    int sampleCount;

    void Update()
    {
        if (sampleCount < 1) return;

        var rms = Mathf.Min(1.0f, Mathf.Sqrt(squareSum / sampleCount));
        var db = 20.0f * Mathf.Log10(rms / refLevel + zeroOffset);
        var meter = -Mathf.Log10(0.1f + db / (minDB * 1.1f));

        transform.localScale = Vector3.one * meter;

        squareSum = 0;
        sampleCount = 0;
    }

    void OnAudioFilterRead(float[] data, int channels)
    {
        for (var i = 0; i < data.Length; i += channels)
        {
            var level = data[i];
            squareSum += level * level;
        }

        sampleCount += data.Length / channels;

        if (mute)
            for (var i = 0; i < data.Length; i++)
                data[i] = 0;
    }
}
