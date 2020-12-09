import Foundation

// Algo Expert - Arrays

// Easy - (Q1-Q2)

// Question 1 - Two Number Sum

// Solution 1 - Brute force
// Time - O(n^2)
// Space - O(n)

func twoNumberSum(_ array: inout [Int], _ targetSum: Int) -> [Int] {
    for i in 0 ..< array.count - 1 {
        let firstNum = array[i]
        
        for j in i + 1 ..< array.count {
            let secondNum = array[j]
            
            if firstNum + secondNum == targetSum {
                return [firstNum, secondNum]
            }
        }
    }
    
    return []
}

// Notes:
// Here I'm using a nested for loop to try every possible combination of integer pairs in the array, checking each pair to see if they match the target sum.
// Note that for the first for loop I go from 0 to the second to last element, not the last element. This is because the first for loop should never reach the last element, as when it reaches the second to last element, the nested for loop will take care of the last element. Since we have the rule stated in the question that you cannot reach the target sum by adding an element to itself, we used the second to last element in this case.


// Solution 2 - Hash Table
// Time - O(n)
// Space - O(n)

func twoNumberSum2(_ array: inout [Int], _ targetSum: Int) -> [Int] {
    var numbersHashMap = [Int: Bool]()
    
    for number in array {
        let potentialMatch = targetSum - number
        
        if numbersHashMap[potentialMatch] == true {
            return [potentialMatch, number]
        } else {
            numbersHashMap[number] = true
        }
    }
    
    return []
}

// Notes:
// The way things work here is, we iterate through the array, and for every value we get to, we solve the equation targetSum - number, and we check if that value (potentialMatch) is in our hash table. If it is, we return potentialMatch and number, if it's not, we add that number to the numbersHashMap.
// Note that since our question specifies that all the integers in the array are unique, it is safe to assume that our hash table will never try to map two elements to the same location, and so checking if a value exists for a given key is an O(1) operation.

// WHY IS CHECKING IF A NUMBER EXISTS IN A HASH TABLE AN O(1) OPERATION? (STACK OVERFLOW)
// Well it's a little bit of a lie -- it can take longer than that, but it usually doesn't.
//
// Basically, a hash table is an array containing all of the keys to search on. The position of each key in the array is determined by the hash function, which can be any function which always maps the same input to the same output. We shall assume that the hash function is O(1).
//
// So when we insert something into the hash table, we use the hash function (let's call it h) to find the location where to put it, and put it there. Now we insert another thing, hashing and storing. And another. Each time we insert data, it takes O(1) time to insert it (since the hash function is O(1).
//
// Looking up data is the same. If we want to find a value, x, we have only to find out h(x), which tells us where x is located in the hash table. So we can look up any hash value in O(1) as well.
//
// Now to the lie: The above is a very nice theory with one problem: what if we insert data and there is already something in that position of the array? There is nothing which guarantees that the hash function won't produce the same output for two different inputs (unless you have a perfect hash function, but those are tricky to produce). Therefore, when we insert we need to take one of two strategies:
//
// Store multiple values at each spot in the array (say, each array slot has a linked list). Now when you do a lookup, it is still O(1) to arrive at the correct place in the array, but potentially a linear search down a (hopefully short) linked list. This is called "separate chaining".
// If you find something is already there, hash again and find another location. Repeat until you find an empty spot, and put it there. The lookup procedure can follow the same rules to find the data. Now it's still O(1) to get to the first location, but there is a potentially (hopefully short) linear search to bounce around the table till you find the data you are after. This is called "open addressing".
// Basically, both approaches are still mostly O(1) but with a hopefully-short linear sequence. We can assume for most purposes that it is O(1). If the hash table is getting too full, those linear searches can become longer and longer, and then it is time to "re-hash" which means to create a new hash table of a much bigger size and insert all the data back into it


// Solution 3 - Sorting (PREFERRED SOLUTION)
// Time - O(nlogn)
// Space - O(1)

func twoNumberSum3(_ array: inout [Int], _ targetSum: Int) -> [Int] {
    array.sort()
    
    var leftIndex = 0
    var rightIndex = array.count - 1
    
    while leftIndex < rightIndex {
        let leftMost = array[leftIndex]
        let rightMost = array[rightIndex]
        
        let currentSum = leftMost + rightMost
        
        if currentSum == targetSum {
            return [leftMost, rightMost]
        } else if currentSum < targetSum {
            leftIndex += 1
        } else if currentSum > targetSum {
            rightIndex -= 1
        }
    }
    
    return []
}

// Notes:
// In this solution, we start with two pointers, a leftIndex and a rightIndex. We start by summing the two pointers, and if the sum is greater than the target sum, we move the right pointer to the left, making the sum smaller, and vice versa.


// Question 2 - Validate SubSequence

// Solution 1 - While loop & indexs (PREFERRED SOLUTION)
// Time - O(n)
// Space - O(1)
func isValidSubsequence(_ array: [Int], _ sequence: [Int]) -> Bool {
    var arrayIndex = 0
    var sequenceIndex = 0
    
    while arrayIndex < array.count, sequenceIndex < sequence.count {
        if array[arrayIndex] == sequence[sequenceIndex] {
            sequenceIndex += 1
        }
        arrayIndex += 1
    }
    return sequenceIndex == sequence.count
}

// Notes:
// In this solution, we start with two indexes set at 0, arrayIndex any sequenceIndex. We then use a while loop on the condition that the indexes haven't reached the end of their arrays, checking at each point to see if the numbers at each index match. If they match, we can increment the sequence index.

// Solution 2
// Time - O(n)
// Space - O(1)
func isValidSubsequence2(_ array: [Int], _ sequence: [Int]) -> Bool {
    var seqIdx = 0
    
    for value in array {
        if seqIdx == sequence.count {
            break
        }
        if value == sequence[seqIdx] {
            seqIdx += 1
        }
    }
    return seqIdx == sequence.count
}

// --------------------------------------------------------------------------------------------------------------------------------

// Medium - (Q3-Q8)

// Question 3 - Three Number Sum

// Question 4 - Smallest Difference

// Question 5 - Move Element To End

// Question 6 - Monotonic Array

// Question 7 - Spiral Traverse

// Question 8 - Longest Peak

// --------------------------------------------------------------------------------------------------------------------------------

// Hard - (Q9-Q13)
// Question 9 - Four Number Sum

// Question 10 - Subarray Sort

// Question 11 - Largest Range

// Question 12 - Min Awards

// Question 13 - Zigzag Traverse

// --------------------------------------------------------------------------------------------------------------------------------

// Very Hard - (Q14-Q15)
// Question 14 - Apartment Hunting

// Question 15 - Calendar Matching

// --------------------------------------------------------------------------------------------------------------------------------

// New - (Q16-17)
// Medium
// Question 16 - Array of Products

// Very Hard
// Question 17 - Waterfall Streams
