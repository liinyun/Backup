magick -density 600 sharp_darkened2.pdf -background white -alpha remove \
   -level 40%,100%,0.5 \
   -threshold 50% \
   -type Bilevel \
   -compress Group4 \
   final_dark_small2.pdf

magick -density 600 extracted_sample.pdf \
   -morphology Erode Diamond:1  sharp_darkened4.pdf

# 提取 1-20页
mutool clean 高等代数640.pdf extracted_sample.pdf 1-20

# crop pdf
pdfcrop --margin -35 实变函数论356.pdf cropped_origin.pdf


pdfunite page_{0..497}.pdf full_book.pdf
