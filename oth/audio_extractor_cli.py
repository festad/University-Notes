import os
import argparse
from moviepy.editor import *
import tqdm


def extract_audio(videos, destination):
    total_clips = len(videos)
    for index, video in enumerate(videos):
        print(f'Extracting audio from {video}')
        video_name = os.path.splitext(os.path.basename(video))[0]
        output_file = os.path.join(destination, f'{video_name}.mp3')
        audioclip = VideoFileClip(video).audio
        audioclip.write_audiofile(output_file, codec='mp3', logger=None, write_logfile=False)
        print(f'Finished extracting audio from {video}')


def main():
    parser = argparse.ArgumentParser(description='Extract audio from videos.')
    parser.add_argument('-d', '--directory', type=str, default=".",
                        help='Directory to save the extracted audio')
    parser.add_argument('-l', '--list', type=str, nargs='+',
                        help='List of video files from which to extract audio')
    args = parser.parse_args()

    # Create directory if not exists
    if not os.path.exists(args.directory):
        os.makedirs(args.directory)

    # If list of files is provided, use it; otherwise, get all video files in the directory
    if args.list:
        videos = args.list
    else:
        videos = [file for file in os.listdir('.') if file.endswith(('.mp4', '.avi', '.mkv', '.flv', '.mov', '.wmv'))]

    extract_audio(videos, args.directory)


if __name__ == '__main__':
    main()
