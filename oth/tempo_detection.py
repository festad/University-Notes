#!/usr/bin/env python3

import librosa

# Command line arguments
import argparse

# argument: path to audio file
parser = argparse.ArgumentParser(description='Detect tempo of audio file')
parser.add_argument('audio_file', metavar='audio_file', type=str, help='path to audio file')
args = parser.parse_args()

# Load audio file
y, sr = librosa.load(args.audio_file)

# Detect tempo
tempo, beat_frames = librosa.beat.beat_track(y=y, sr=sr)

# Print tempo
print(tempo)