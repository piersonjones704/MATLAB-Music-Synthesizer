# MATLAB Music Synthesizer

A MATLAB script that synthesizes a full piano arrangement entirely from scratch: no samples, no MIDI, no audio libraries. Every note is built up mathematically from sine waves, shaped and layered until it sounds like a real instrument, then mixed down and exported as a finished `.wav` file.

*ECE280 Signals and Systems Lab Project*

## Overview

This project explores how digital audio synthesis works at the signal level. A piece of music is represented as nothing more than a sequence of numbers (samples) and every characteristic of sound. These characteristics of sound - including pitch, rhythm, timbre, and spatial depth - can be built from basic trigonometric and exponential functions applied to those samples.

The script synthesizes a full two-part piano arrangement (melody and bass) from first principles and combines several classic signal-processing techniques to turn simple tones into something that sounds like an actual performed piece of music.

## How it works

**Pitch generation**: Every note frequency is computed directly from the equal-temperament formula

```
f = 440 * 2^(n/12)
```

where `n` is the number of semitones above or below A4 (440 Hz). From this, the full chromatic scale is built programmatically across every octave needed for the piece, including enharmonic equivalents (e.g., A♭ derived from G♯).

**Rhythm and timing**: Note durations (sixteenth, eighth, quarter, dotted, tied, etc.) are derived from the song's tempo and converted into discrete time vectors at a 44.1 kHz sample rate, the same rate used in standard digital audio.

**Signal processing effects**: Four effects are layered on top of the raw tones to shape the final sound:

| Effect | What it does |
|---|---|
| **Exponential decay** | Shapes each note's amplitude envelope so it fades out naturally, like a struck piano string, instead of cutting off abruptly |
| **Harmonic (additive) synthesis** | Layers scaled 2nd and 3rd harmonics on top of each note's fundamental frequency, enriching a plain sine tone into something closer to a real instrument's timbre |
| **Multiple simultaneous notes (chords)** | Synthesizes and sums several pitches at once for the bass line, adding harmonic depth beyond a single melodic voice |
| **Reverb / echo** | Adds a delayed, attenuated copy of the full mix back onto itself, simulating acoustic reflection and giving the recording a sense of space |

**Mixing and export**: The melody and bass lines are synthesized independently, aligned and summed into a single signal, processed through the echo stage, normalized to prevent clipping, and written out as a standard `.wav` file.

## Tech stack

- **MATLAB**: signal generation, array/vector operations, and audio I/O (`soundsc`, `audiowrite`)

## Output

A normalized, 73 second `.wav` recording of an original synthesized piano arrangement, generated entirely by the script with no external audio sources.
