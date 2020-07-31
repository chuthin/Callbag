# Callbag

[![CI Status](https://img.shields.io/travis/chuthin/Callbag.svg?style=flat)](https://travis-ci.org/chuthin/Callbag)
[![Version](https://img.shields.io/cocoapods/v/Callbag.svg?style=flat)](https://cocoapods.org/pods/Callbag)
[![License](https://img.shields.io/cocoapods/l/Callbag.svg?style=flat)](https://cocoapods.org/pods/Callbag)
[![Platform](https://img.shields.io/cocoapods/p/Callbag.svg?style=flat)](https://cocoapods.org/pods/Callbag)

This is an attempt to build [Callbag](https://github.com/callbag/callbag) protocol founded by [André Staltz](https://github.com/staltz) in Swift.
# Specification
  Talkback = (_ payload:Any?) -> Void
  
  Sink<T> = (_ payload:Payload<T>) -> Void
  
  Source<T> = (_ sink:@escaping Sink<T>) -> Void;
# Functions have been implemented

## Source factories
  - fromArrays
  - fromInterval
  - fromSubject
## Sink factories
  - forEach
## Transformation operators
  - map
  - filter
  - take
  - skip
  - scan
## Combination operators  
  - merge
  - combine
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
# Reactive programming examples

Pick the first 5 odd numbers from a clock that ticks every second, then start observing them:
```swift
   fromInterval(1)
      +> map{ $0 + 1}
      +> filter{ $0 % 2 != 0}
      +> take(5)
      +> forEach{ print($0)}
   //1
   //3
   //5
   //7
   //9
```
From a array
```swift
    fromArray([1,2,3,4,5,6,7,8,9]) // 1, 2, 3, 4, 5, 6, 7, 8, 9,
       *> filter{ $0 % 2 == 0}    // 2, 4, 6, 8
       *> map { $0 * 2}           // 4, 8, 12, 16
       *> subscribe{ print($0)}
        
    //4
    //8
    //12
    //16
```
## Installation

Callbag is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:
```ruby
pod 'Callbag'
```
## References
  - [https://staltz.com/why-we-need-callbags.html](https://staltz.com/why-we-need-callbags.html)
  - [http://blog.krawaller.se/posts/callbags-introduction/](http://blog.krawaller.se/posts/callbags-introduction/)
  - [http://blog.krawaller.se/posts/explaining-callbags-via-typescript-definitions/](http://blog.krawaller.se/posts/explaining-callbags-via-typescript-definitions/)
  - [https://wonka.kitten.sh/](https://wonka.kitten.sh/)
## License

Callbag is available under the MIT license. See the LICENSE file for more info.
