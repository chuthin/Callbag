# Callbag

[![CI Status](https://img.shields.io/travis/chuthin/Callbag.svg?style=flat)](https://travis-ci.org/chuthin/Callbag)
[![Version](https://img.shields.io/cocoapods/v/Callbag.svg?style=flat)](https://cocoapods.org/pods/Callbag)
[![License](https://img.shields.io/cocoapods/l/Callbag.svg?style=flat)](https://cocoapods.org/pods/Callbag)
[![Platform](https://img.shields.io/cocoapods/p/Callbag.svg?style=flat)](https://cocoapods.org/pods/Callbag)

This is an attempt to build [Callbag](https://github.com/callbag/callbag) protocol founded by [André Staltz](https://github.com/staltz) in Swift.

#  Functions have been implemented

## Source factories
  - fromValues
  - fromArrays
  - fromInterval
  - fromEvent
  - textFrom
## Sink factories
  - forEach
## Transformation operators
  - map
  - filter
  - take
  - takeUntil
  - skip
  - skipUntil
  - scan
## Combination operators  
  - merge
  - combineLastest
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
# Counter
```swift
public class CounterViewController : UIViewController {
    @IBOutlet weak var increButton: UIButton!
    @IBOutlet weak var decreButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let incre = Callbag.fromEvent(increButton, .touchUpInside)
            .map{_ in 1}
        let decre = Callbag.fromEvent(decreButton, .touchUpInside)
            .map{_ in -1}
        
        Callbag.merge(incre,decre)
            .scan(0){$0 + $1}
            .forEach{ [weak self] value in
                self?.counterLabel.text = "\(value)"
            }     
    }
}
```swift

## Requirements
  - [ActionKit](https://github.com/ActionKit/ActionKit)
## Installation

Callbag is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:
pod 'Callbag'

## References
  - [https://staltz.com/why-we-need-callbags.html](https://staltz.com/why-we-need-callbags.html)
  - [http://blog.krawaller.se/posts/callbags-introduction/](http://blog.krawaller.se/posts/callbags-introduction/)
  - [http://blog.krawaller.se/posts/explaining-callbags-via-typescript-definitions/](http://blog.krawaller.se/posts/explaining-callbags-via-typescript-definitions/)
  - [https://wonka.kitten.sh/](https://wonka.kitten.sh/)
## License

Callbag is available under the MIT license. See the LICENSE file for more info.
