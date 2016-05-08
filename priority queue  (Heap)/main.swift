//
//  main.swift
//  priority queue  (Heap)
//
//  Created by Ahmed masoud on 4/16/16.
//  Copyright © 2016 Ahmed masoud. All rights reserved.
//

import Foundation

var index:Int = 0

struct Node {
    var data : Int
    var priority : Int
    var index : Int
}

var unsortedArray:Array<Node> = []

func input() -> String {
    var keyboard = NSFileHandle.fileHandleWithStandardInput()
    var inputData = keyboard.availableData
    return NSString(data: inputData, encoding:NSUTF8StringEncoding) as! String
}

func exchange<T>(inout data: [T], i:Int, j:Int) {
    let temp:T = data[i]
    data[i] = data[j]
    data[j] = temp
}

func leftLeafIndex(let rootIndex:Int)->Int{
    let heapIndex = rootIndex+1
    return heapIndex*2-1
    
}

func rightLeafIndex(let rootIndex:Int)->Int{
    let heapIndex = rootIndex+1
    return heapIndex*2-1+1
}

func heapLastIndex(let A:Array<Node>)->Int{
    return A.count-1
    
}

func maxHeapify(inout A:Array<Node>,let indexRoot:Int){
    if leftLeafIndex(indexRoot)>heapLastIndex(A) {return}
    let rootValue = A[indexRoot].priority
    var largestIndex = indexRoot
    var largestValue = rootValue
    if let leftLeafValue = A[leftLeafIndex(indexRoot)].priority as Int!{
        if leftLeafValue > largestValue {
            largestValue = leftLeafValue
            largestIndex = leftLeafIndex(indexRoot)
        }
    }
    if rightLeafIndex(indexRoot)<=heapLastIndex(A){
        if let rightLeafValue = A[rightLeafIndex(indexRoot)].priority as Int!{
            if rightLeafValue > largestValue {
                largestValue = rightLeafValue
                largestIndex = rightLeafIndex(indexRoot)
            }
        }
    }
    if largestIndex != indexRoot {
        exchange(&A, i: indexRoot, j: largestIndex)
        maxHeapify(&A,indexRoot: largestIndex)
    }
    
}

func buildMaxHeap(inout A:Array<Node>){
    if A.count<2 {return}
    var lastParentIndex:Int = A.count/2
    while lastParentIndex >= 0 {
        maxHeapify(&A, indexRoot: lastParentIndex)
        lastParentIndex -= 1;
    }
    
}

func getIndex(A:Array<Node>,node : Node)->Int{
    var i = 0
    for i=0 ; i<A.count ; i+=1{
        if node.data == A[i].data && node.priority == A[i].priority {
            return i
        }
    }
    return -1
}

func deque(inout A:Array<Node>)->Node{
    for node in A {
        if node.priority == A[0].priority {
            if node.index<A[0].index {
                exchange(&A, i: 0, j: getIndex(A, node: node))
            }
        }
    }
    let dequed = A[0]
    exchange(&A, i: 0, j: A.count-1)
    A.removeLast()
    buildMaxHeap(&A)
    return dequed
    
}

func enque(inout A:Array<Node>,data : Node){
    A.append(data)
    buildMaxHeap(&A)
    index += 1
}

//Main

/*var node1 = Node(data: 7, priority: 1,index: -1)
var node2 = Node(data: 400, priority: 2,index: -1)
var node3 = Node(data: 1, priority: 3,index: 0)
var node4 = Node(data: 500, priority: 3,index: 1)
var node5 = Node(data: 14, priority: 3,index: 2)
var node6 = Node(data: 2, priority: 6,index: -1)
var node7 = Node(data: 3, priority: 7,index: -1)


enque(&unsortedArray, data: node1)
 var bibo = unsortedArray
 enque(&unsortedArray, data: node2)
 enque(&unsortedArray, data: node3)
 enque(&unsortedArray, data: node4)
 enque(&unsortedArray, data: node5)
 enque(&unsortedArray, data: node6)
 enque(&unsortedArray, data: node7)
for node in unsortedArray{
    print("priority :\(node.priority)  and data : \(node.data) and index : \(node.index)")
}
 print("deq")
 print(deque(&unsortedArray))
 print(deque(&unsortedArray))
 print(deque(&unsortedArray))
 print(deque(&unsortedArray))
 print(deque(&unsortedArray))
 print(deque(&unsortedArray))
 print(deque(&unsortedArray))
 */

while(true){
    print("------------------------------------------------------------------------------")
    print("Enter Desired operation : ",terminator:"")
    var operation = input()
    operation = String(operation.characters.dropLast(1))
    switch(operation){
    case "enq":
        print("Enter Node Priority : ",terminator:"")
        var priority = input()
        priority = String(priority.characters.dropLast(1))
        if Int(priority) == nil{
            print("invalid input")
            continue
        }
        print("Enter Node Value : ",terminator:"")
        var value = input()
        value = String(value.characters.dropLast(1))
        if Int(value) == nil{
            print("invalid input")
            continue
        }
        enque(&unsortedArray, data:Node(data: Int(value)!, priority: Int(priority)!, index: index))
        break
    case "deq":
        if unsortedArray.count>0{
            print(deque(&unsortedArray))
        }else{
            print("Queue is empty")
        }
        
        
        break
    case "print":
        if unsortedArray.count>0{
            for node in unsortedArray{
                print("priority :\(node.priority)  and data : \(node.data) and index : \(node.index)")
            }
        }else{
            print("Queue is empty")
        }

        break
        
    case "quit":
        exit(0)
        break
    default:
        print("un-defined operation")
        
        break
    }
    
}











