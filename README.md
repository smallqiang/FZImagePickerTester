# FZImagePickerTester

I noticed a weird behavior: if you pinch down a square or landscape
image in a UIImagePickerController that allows editing, the crop rect
you get back doesn't match what I seem to see on the preview. Basically,
the crop should be the scaled down original image, but for whatever
reason, I get crop rects a few pixels off in some direction. 

So, about to report this to apple.

## steps to reproduce

1. Build and run app
2. tap the Launch UIImagePickerController button
3. pick a landscape or square image from your library.
4. in the editing window that comes up, pinch the image down so that
   it's smaller than the square, let go.
5. Tap "use" or "choose" depending on your device. 
6. Look at the crop rect and edited size. Note it down.
7. Run steps 2-6 again, *skipping* step 4.
8. Note that the preview images looked the same to the naked eye, yet
   the second run crops differently than the first run even though they
should do the same thing.
