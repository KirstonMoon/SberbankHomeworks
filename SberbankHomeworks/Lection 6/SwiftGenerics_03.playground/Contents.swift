import UIKit

// MARK: - Задача 3*. К выполнению необязательна. 

enum LinkedList<T> {
    indirect case Cons(T, LinkedList<T>)
    case Nil
}

let list = LinkedList.Cons(1, .Cons(2, .Cons(3, .Nil)))


