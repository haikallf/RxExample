import Foundation
import RxSwift
import RxCocoa

/*
 RxSwift Beginners Episode 3
 
 Observable (sequence) - emits events (notifications of change) asyncronously
 Observer - subscribes to Observable in order to receive events
 
 Subject = Observable + Observer
 - PublishSubject - only emits new elements to subscribers
 - BehaviorSubiect - emits the last element to new subscribers
 - ReplaySubject - emits a buffer size of elements to new subscribers
 - AsyncSubject - emits only the last next event in the sequence, and only when the subject receives a completed event.
 
 Relays = Wrapers around Subjects that never complete
 - Publish Relay
 - BehaviorRelay
 */

// MARK: - Publish Subject
print("====")
let pSub = PublishSubject<String>()
pSub.onNext("pSub Elmt 1")

let obsv1 = pSub.subscribe(onNext: { elmt in
    print(elmt)
})
pSub.onNext("pSub Elmt 2")


// MARK: - Behaviour Subject
print("====")
let bSub = BehaviorSubject<String>(value: "bSub Elmt 1")

let obsv2 = bSub.subscribe(onNext: { elmt in
    print(elmt)
})


// MARK: - Replay Subject
print("====")
let rSub = ReplaySubject<Int>.create(bufferSize: 2)
rSub.onNext(1)
rSub.onNext(2)
rSub.onNext(3)

let obsv3 = rSub.subscribe(onNext: { elmt in
    print(elmt)
})


// MARK: - Async Subject
print("====")
let aSub = AsyncSubject<String>()
aSub.onNext("aSub Elmt 1")
aSub.onNext("aSub Elmt 2")
aSub.onCompleted()

let obsv4 = aSub.subscribe(onNext: { elmt in
    print(elmt)
})



// MARK: - Publish Relay
print("====")
let pRel = PublishRelay<String>()
pRel.accept("pRel Elmt 1")

let obsv5 = pRel.subscribe(onNext: { elmt in
    print(elmt)
})
pRel.accept("pRel Elmt 2")


// MARK: - Behaviour Relay
print("====")
let bRel = BehaviorRelay<String>(value: "bRel Elmt 1")

let obsv6 = bRel.subscribe(onNext: { elmt in
    print(elmt)
})
