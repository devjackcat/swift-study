//
//  CounterViewReactor.swift
//  swift-study
//
//  Created by 永平 on 2020/6/11.
//  Copyright © 2020 永平. All rights reserved.
//

import RxSwift
import ReactorKit

class CounterViewReactor: Reactor {
    
    enum Action {
      case increase
      case decrease
    }
    
    // Mutate is a state manipulator which is not exposed to a view
    enum Mutation {
      case increaseValue
      case decreaseValue
      case setLoading(Bool)
    }
    
    // State is a current view state
    struct State {
      var value: Int
      var isLoading: Bool
    }
    
    let initialState: State
    
    init() {
      self.initialState = State(
        value: 0, // start from 0
        isLoading: false
      )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.concat(
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.setLoading(false)).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(Mutation.increaseValue)
            )
        case .decrease:
            return Observable.concat(
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.setLoading(false)).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(Mutation.decreaseValue)
            )
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .increaseValue:
            state.value += 1
            
        case .decreaseValue:
            state.value -= 1
            
        case let .setLoading(isLoading):
            state.isLoading = isLoading
            
        }
    
        return state
        
    }
    
}
