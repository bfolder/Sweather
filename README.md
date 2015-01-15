## Readme
[![Build Status](https://travis-ci.org/bfolder/Sweather.svg?branch=master)](https://travis-ci.org/bfolder/Sweather)

Sweather is a Swift wrapper around the openweathermap api.
For detailed information about different api calls have a look at the official page [here](http://openweathermap.org).

The example project shows how to use the Sweather class in your own code.

You can call it like that:

```swift
let client = Sweather(apiKey: "your_key")
client.currentWeather("Berlin") { result in
	// Do something here
}
```

---
### Requirements
+ Xcode 6 (Beta)
+ iOS 7+ / Mac OS X 10.9+

---
### Installation
As for now, you can just drag & drop Sweather.swift into your project.

---
## Licensing

Sweather is licensed under MIT License. Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
