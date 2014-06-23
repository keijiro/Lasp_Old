Lasp
====

Lasp is a native plugin for Unity which provides a low-latency audio stream from
the system audio interface.

Rationale
---------

Real-time audio processing is a tough topic in Unity. Although [it is possible]
[Kaappine] to get an audio stream with the Microphone class, it has noticeable
latency (more than 20ms) and doesn't suit for making audio-visual applications.

Lasp provides a workaround for it. It captures audio signals with the Core Audio
low-level API and routes it to Unity via a custom audio filter. With these
techniques, it is possible to keep the latency quite low (less then 10ms).

[Kaappine]: http://www.kaappine.fi/tutorials/using-microphone-input-in-unity3d/

Limitations
-----------

- Runs only on OS X at the moment.
- Requires Unity Pro.

Contacts
--------

https://github.com/keijiro
