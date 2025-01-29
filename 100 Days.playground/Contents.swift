import Foundation

class Animal {
    var legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print( "Woof!" )
    }
}

class Poodle: Dog {
    override func speak() {
        print( "Yip!" )
    }
}

class Corgi: Dog {
    override func speak() {
        print("pip pip!")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    init(isTame: Bool, legs: Int) {
        self.isTame = isTame
        super.init(legs: legs)
    }
    
    func speak() {
        print( "Meow!" )
    }
}

class PersianCat: Cat {
    override func speak() {
        print( "Loud Meow!" )
    }
}

class Lion: Cat {
    override func speak() {
        print( "Roar!" )
    }
}

//var dog1: Dog = Poodle(legs: 4)
////dog1.speak()
//
//var dog2: Poodle = Poodle(legs: 4)
////dog2.speak()
//
//var dog3: Dog = Dog(legs: 4)
////dog3.speak()
//
//var cat1 = PersianCat(isTame: true, legs: 4)
////cat1.speak()
//
//var cat2 = Lion(isTame: false, legs: 4)
//cat2.speak()
