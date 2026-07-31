# get the length of video
ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 input.mp4

# crop videos
ffmpeg -ss 627.439 -i '3月24日 (1)(18).mp4' -c copy 3月24日.mp4

convert from 16:9 to vertical
ffmpeg -i OnlyFans.Rikako.Katayama.VS.Mike.Williams.1080p.mp4 -vf "crop=ih*9/16:ih" -c:a copy output.mp4

ffmpeg -i output1.mp4 -ss 5 -c copy output.mp4


ffmpeg -ss 00:10:50 -i '8月18日 (7).mp4' -c copy output.mp4 
