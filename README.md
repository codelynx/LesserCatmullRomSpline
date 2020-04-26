# Lesser Catmull Rom Spline


I spent sometime to find how to implement Catmull-Rom spline as bezier path in iOS.  I realized that some code on the net are partially working or partially broken.  Others are simply written in other language and I can't tell it is working code or not until I do hand port and try.

Due to the nature of this mechanics, codes are a bit too hard to understand what those code are trying to do.  So step back and trying to understand the concept behind the theory and I implemented in my own way.

My purpose of using Catmull-Rom spline is just make a smooth bezier line from number of points touch on a screen.  Since Apple Pencil arrive, perhaps you may not need line smoothing any more, but I still like to stick with it.

Catmull-Rom spline requires 4 points to make a curve with a bit complicated steps to calculate.  I mimic the idea of Catmull-Rom spline using three points to make a curve, so I called Lesser Catmull Rom spline.

I provide a working Xcode project to test this algorithm, so you can try to see at least this code is broken or not.

<img width=600 src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/65634/8a3f5ebb-8758-e606-af04-487439b9f2ef.png"/>

### License

MIT License

### Environment

```.log
Xcode Version 11.4.1 (11E503a)
Apple Swift version 5.2.2 (swiftlang-1103.0.32.6 clang-1103.0.32.51)
Target: x86_64-apple-darwin19.4.0
```
