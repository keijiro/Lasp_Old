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

License
-------

Copyright (C) 2014 Keijiro Takahashi

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
