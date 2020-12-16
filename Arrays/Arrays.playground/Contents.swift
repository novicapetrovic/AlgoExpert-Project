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

// Question: When you call array.sort() in swift, what type of sort is swift doing under the hood?



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

// Solution 1 - Brute Force (Not a solution on AlgoExpert)
// Time - O(n^3)
// TODO: Space - O(?)
func threeNumberSum(array: inout [Int], targetSum: Int) -> [[Int]] {
    var output = [[Int]]()
    array.sort()
    
    for i in 0 ..< array.count - 2 {
        for j in i + 1 ..< array.count - 1 {
            for k in j + 1 ..< array.count {
                if array[i] + array[j] + array[k] == targetSum {
                    output.append([array[i], array[j], array[k]])
                }
            }
        }
    }
    
    return output
}

// Notes:
// Since it's a requirement in this question that the triplets we return are sorted, I have put array.sort() at the beginning to solve that problem.

// Solution 2 - For loop & while loop (PREFERRED SOLUTION)
// Time - O(n^2)
// Space - O(n)
func threeNumberSum2(array: inout [Int], targetSum: Int) -> [[Int]] {
    array.sort()
    var output = [[Int]]()
    
    for i in 0 ..< array.count - 2 {
        let base = i
        var left = base + 1
        var right = array.count - 1
        
        while left < right {
            let currentSum = array[base] + array[left] + array[right]
            
            if currentSum == targetSum {
                output.append([array[base], array[left], array[right]])
                left = left + 1
                right = right - 1
            } else if array[base] + array[left] + array[right] < targetSum {
                left += 1
            } else if array[base] + array[left] + array[right] > targetSum {
                right -= 1
            }
        }
    }
    
    return output
}

// Notes:
// In this solution, I'm fixing a base pointera the beginning, then using a similar approach as in two number sum by using a left and a right pointer. Note that when we've found a solution, it's safe to both increment the left pointer and decrement the right pointer as only doing one would not result in a solution since all the values in the array are unique.



// Question 4 - Smallest Difference

// Solution 1 - Brute Force
// Time - O(n^2)
// Space - O(1)
func smallestDifference(arrayOne: inout [Int], arrayTwo: inout [Int]) -> [Int] {
    var smallest = Int.max
    var output = [Int]()
    
    for i in 0 ..< arrayOne.count {
        for j in 0 ..< arrayTwo.count {
            let difference = abs(arrayOne[i] - arrayTwo[j])
            if difference < smallest {
                smallest = difference
                output = []
                output.append(contentsOf: [arrayOne[i], arrayTwo[j]])
            }
        }
    }
    
    return output
}

// Solution 2 - Using pointers (PREFERRED SOLUTION)
// TODO: Time - O(?)
// Space - O(1)
func smallestDifference2(arrayOne: inout [Int], arrayTwo: inout [Int]) -> [Int] {
    arrayOne.sort()
    arrayTwo.sort()
    
    var indexOne = 0
    var indexTwo = 0
    
    var smallestDifference = Int.max
    var output = [Int]()
    
    while indexOne < arrayOne.count, indexTwo < arrayTwo.count {
        let firstNum = arrayOne[indexOne]
        let secondNum = arrayTwo[indexTwo]
        
        let current = firstNum - secondNum
        
        if abs(current) < smallestDifference {
            smallestDifference = abs(current)
            output = []
            output.append(contentsOf: [firstNum, secondNum])
        }
        
        if firstNum > secondNum {
            indexTwo += 1
        } else if firstNum < secondNum {
            indexOne += 1
        } else {
            return [firstNum, secondNum]
        }
    }
    
    return output
}



// Question 5 - Move Element To End

// Solution 1 - Swapping method (PREFERRED METHOD)
// Time - O(n)
// Space - O(1)
func moveElementToEnd(_ array: inout [Int], _ toMove: Int) -> [Int] {
    var leftIndex = 0
    var rightIndex = array.count - 1
    
    while leftIndex < rightIndex {
        while leftIndex < rightIndex, array[rightIndex] == toMove {
            rightIndex -= 1
        }
        
        if array[leftIndex] == toMove {
            (array[leftIndex], array[rightIndex]) = (array[rightIndex], array[leftIndex])
        }
        leftIndex += 1
    }
    
    return array
}

// Notes:
// This question taught me 2 things:
// 1) It can sometimes be necessary to use 2 while loops, where one while loop is a subset of the other (this surprised me).
// 2) The swapping technique with a left and right pointer

// Solution 2 - My original solution (way too over complicated)
// Time - O(n)
// TODO: Space - O(?)
func moveElementToEnd2(_ array: inout [Int], _ toMove: Int) -> [Int] {
    var counter = 0
    var toMoveIdxs = [Int]()
    
    if array.isEmpty {
        return []
    }
    
    for i in 0...array.count - 1 {
        if array[i] == toMove {
            toMoveIdxs.append(i)
        }
    }
    
    for i in 0...array.count - 1 {
        if toMoveIdxs.contains(i) {
            array.remove(at: i - counter)
            counter += 1
        }
    }
    
    if toMoveIdxs.isEmpty {
        return array
    } else {
        for _ in 0...toMoveIdxs.count - 1 {
            array.append(toMove)
        }
    }
    return array
}



// Question 6 - Monotonic Array

// Solution 1 - Use a temp array to store direction
// Time - O(n)
// Space - O(1)
func isMonotonic(array: [Int]) -> Bool {
    var temp = [String]()
    
    if array.count < 3 {
        return true
    }
    
    for i in 0 ..< array.count - 1 {
        let difference = array[i+1] - array[i]
        if difference > 0 {
            temp.append("+")
        } else if difference < 0 {
            temp.append("-")
        }
        
        if temp.contains("+") && temp.contains("-") {
            return false
        }
    }
    return true
}


// Solution 2 - Compare first and last to get a direction (PREFERRED SOLUTION)
// Time - O(n)
// Space - O(1)
func isMonotonic2(array: [Int]) -> Bool {
    if array.isEmpty || array.count == 1 {
        return true
    }
    
    let first = array[0]
    let last = array[array.count - 1]
    let direction = last - first
    
    if direction > 0 {
        for i in 0...array.count - 2 {
            if array[i+1] < array[i] {
                return false
            }
        }
    } else if direction < 0 {
        for i in 0...array.count - 2 {
            if array[i+1] > array[i] {
                return false
            }
        }
    } else if direction == 0 {
        for i in 0...array.count - 2 {
            if array[i+1] != array[i] {
                return false
            }
        }
    }
    return true
}



// Question 7 - Spiral Traverse (VERY COMMON INTERVIEW QUESTION)

// Solution 1 - Perimeter, broken  down by helper functions (NOT PASSING TESTS AS CURRENT SOLUTION DOESN'T HANDLE SINGLE ROW OR COLUMN EDGE CASES)
func spiralTraverse(array: [[Int]]) -> [Int] {
    var output = [Int]()
    var startRowIndex = 0
    var endColumnIndex = array[0].count - 1
    var endRowIndex = array.count - 1
    var startColumnIndex = 0
    
    while startRowIndex <= endRowIndex && startColumnIndex <= endColumnIndex {
        let startRow = createRow(array: array, start: startColumnIndex, end: endColumnIndex, row: startRowIndex)
        let endColumn = createColumn(array: array, start: startRowIndex, end: endRowIndex, column: endColumnIndex)
        var endRow = createRow(array: array, start: startColumnIndex, end: endColumnIndex, row: endRowIndex)
        var startColumn = createColumn(array: array, start: startRowIndex, end: endRowIndex, column: startColumnIndex)
        
        
        let perimeter = traversePerimeter(startRow: startRow, endColumn: endColumn, endRow: &endRow, startColumn: &startColumn)
        output.append(contentsOf: perimeter)
        
        startRowIndex += 1
        endColumnIndex -= 1
        endRowIndex -= 1
        startColumnIndex += 1
    }
    
    return output
}

func createRow(array: [[Int]], start: Int, end: Int, row: Int) -> [Int] {
    var startRow = [Int]()
    
    for i in start ... end {
        startRow.append(array[row][i])
    }
    
    return startRow
}

func createColumn(array: [[Int]], start: Int, end: Int, column: Int) -> [Int] {
    var endColumn = [Int]()
    
    for i in start ... end {
        endColumn.append(array[i][column])
    }
    
    return endColumn
}

func traversePerimeter(startRow: [Int], endColumn: [Int], endRow: inout [Int], startColumn: inout [Int]) -> [Int] {
    var output = [Int]()
    
    if startRow.count == 1 {
        return startRow
    } else if startColumn.count == 1 {
        return startColumn
    }
    
    for i in 0 ..< startRow.count {
        output.append(startRow[i])
    }
    
    for i in 1 ..< endColumn.count {
        output.append(endColumn[i])
    }
    
    endRow.reverse()
    for i in 1 ..< endRow.count {
        output.append(endRow[i])
    }
    
    startColumn.reverse()
    for i in 1 ..< startColumn.count - 1 {
        output.append(startColumn[i])
    }
    
    return output
}


// Solution 2 - Perimeter approach, Iterative solution
// Time - O(n)
// Space - O(n)

func spiralTraverse4(array: [[Int]]) -> [Int] {
    // Indexes
    var startRow = 0
    var endRow = array.count - 1
    var startCol = 0
    var endCol = array[0].count - 1
    
    var output = [Int]()
    
    while startRow <= endRow, startCol <= endCol {
        
        // Sweep left to right
        for col in stride(from: startCol, through: endCol, by: 1) {
            output.append(array[startRow][col])
        }
        
        // Sweep top to bottom
        for row in stride(from: startRow + 1, through: endRow, by: 1) {
            output.append(array[row][endCol])
        }
        
        // Sweep right to left
        for col in stride(from: endCol - 1, through: startCol, by: -1) {
            // We need to check if startRow == endRow, because if it does, we have already counted this row in the left to right sweep.
            if startRow == endRow {
                break
            }
            
            output.append(array[endRow][col])
        }
        
        // Sweep bottom to top
        for row in stride(from: endRow - 1, through: startRow + 1, by: -1) {
            // We need to check if startCol == endCol, because if it does, we have already counted this column in the top to bottom sweep.
            if startCol == endCol {
                break
            }
            
            output.append(array[row][startCol])
        }
        
        startRow += 1
        endRow -= 1
        startCol += 1
        endCol -= 1
    }
    
    return output
}

// Note:
// This solution uses a lot less code than solution 1, and the good thing about this solution is that unlike solution 1 which uses a traversePerimeter function that takes in a set of input arrays, this uses indexes to handle the edge cases (if startRow = endRow break)


// Solution 3 - Perimeter approach, recursive solution
// Time - O(n)
// Space - O(n)
func spiralTraverse3(array: [[Int]]) -> [Int] {
    var output = [Int]()
    spiralFill(array, 0, array.count - 1, 0, array[0].count - 1, &output)
    return output
}

func spiralFill(_ array: [[Int]], _ startRow: Int, _ endRow: Int, _ startCol: Int, _ endCol: Int, _ output: inout [Int]) {
    if startRow > endRow || startCol > endCol {
        return
    }
    
    for col in stride(from: startCol, through: endCol, by: 1) {
        output.append(array[startRow][col])
    }
    
    for row in stride(from: startRow + 1, through: endRow, by: 1) {
        output.append(array[row][endCol])
    }
    
    for col in stride(from: endCol - 1, through: startCol, by: -1) {
        if startRow == endRow {
            break
        }
        output.append(array[endRow][col])
    }
    
    for row in stride(from: endRow - 1, through: startRow + 1, by: -1) {
        if startCol == endCol {
            break
        }
        output.append(array[row][startCol])
    }
    
    spiralFill(array, startRow + 1, endRow - 1, startCol + 1, endCol - 1, &output)
}



// Question 8 - Longest Peak

// Solution 1 - Find potential peaks by comparing the left and right, then iterate through the potential peaks and count the left & right sides.
// Time - O(n)
// Space - O(n)
func longestPeak(array: [Int]) -> Int {
    var longestPeak = 0
    var potentialPeaks = [Int]()
    
    if array.count < 3 {
        return 0
    }
    
    for i in 1 ..< array.count - 1 {
        if array[i] > array[i-1] && array[i] > array[i+1] {
            potentialPeaks.append(i)
        }
    }

    for i in 0 ..< potentialPeaks.count {
        var leftSide = 0
        var j = potentialPeaks[i]
        while j-1 >= 0, array[j-1] < array[j] {
            leftSide += 1
            j -= 1
        }

        var rightSide = 0
        var k = potentialPeaks[i]
        while k+1 <= array.count - 1, array[k+1] < array[k] {
            rightSide += 1
            k += 1
        }
        
        let sum = leftSide + rightSide + 1
        if sum > longestPeak {
            longestPeak = sum
        }
    }
    
    return longestPeak
}

// Notes: Solution 2 is better than solution 1 here because the memory complexity of solution 1 is worst case O(n). Solution 2 solves this memory problem by not storing potential peaks in an array and iterating through the array and only counting the left and right sides if the point in the array is a potential peak.

// Solution 2 - AlgoExpert Solution
// Time - O(n)
// Space - O(1)
func longestPeak2(array: [Int]) -> Int {
    var longestPeak = 0
    var potentialPeaks = [Int]()
    
    if array.count < 3 {
        return 0
    }
    
    for i in 1 ..< array.count - 1 {
        if array[i] > array[i-1] && array[i] > array[i+1] {
            potentialPeaks.append(i)
        }
    }

    for i in 0 ..< potentialPeaks.count {
        // count the left
        var leftSide = 0
        var j = potentialPeaks[i]
        while j-1 >= 0, array[j-1] < array[j] {
            leftSide += 1
            j -= 1
        }
        
        // count the right
        var rightSide = 0
        var k = potentialPeaks[i]
        while k+1 <= array.count - 1, array[k+1] < array[k] {
            rightSide += 1
            k += 1
        }
        
        // sum
        let sum = leftSide + rightSide + 1
        if sum > longestPeak {
            longestPeak = sum
        }
    }
    
    return longestPeak
}

// --------------------------------------------------------------------------------------------------------------------------------

// Hard - (Q9-Q13)
// Question 9 - Four Number Sum

// Solution 1 - Brute force
// Time - O(n^4)
// Space - O(n)
func fourNumberSum(array: [Int], targetSum: Int) -> [[Int]] {
    var output = [[Int]]()
    let myArray = array.sorted()
    
    for i in 0 ..< myArray.count - 3 {
        for j in i+1 ..< myArray.count - 2 {
            for k in j+1 ..< myArray.count - 1 {
                for l in k+1 ..< myArray.count {
                    if myArray[i] + myArray[j] + myArray[k] + myArray[l] == targetSum {
                        output.append([myArray[i], myArray[j], myArray[k], myArray[l]])
                    }
                }
            }
        }
    }
    
    return output
}

// Solution 2 - Using Pointers
// Time - O(n^3)
// TODO: Space - O(?)
func fourNumberSum2(array: [Int], targetSum: Int) -> [[Int]] {
    var output = [[Int]]()
    let myArray = array.sorted()
    
    for i in 0 ..< myArray.count - 3 {
        for j in i+1 ..< myArray.count - 2 {
            
            let firstBase = myArray[i]
            let secondBase = myArray[j]
            
            var leftPointer = j+1
            var rightPointer = myArray.count - 1
            
            while leftPointer < rightPointer {
                let leftValue = myArray[leftPointer]
                let rightValue = myArray[rightPointer]
                let sum = firstBase + secondBase + leftValue + rightValue
                
                if sum < targetSum {
                    leftPointer += 1
                } else if sum > targetSum {
                    rightPointer -= 1
                } else {
                    output.append([firstBase, secondBase, leftValue, rightValue])
                    leftPointer += 1
                }
            }
        }
    }
    
    return output
}

// Solution 3 - AlgoExpert Solution, finding pairs + hash table (PREFERRED SOLUTION, HOWEVER NOT SIMPLEST)
// Time - O(n^2)
// Space - O(n^2)
func fourNumberSum3(array: [Int], targetSum: Int) -> [[Int]] {
    var output = [[Int]]()
    var hashTable = [Int: [[Int]]]()
    
    for i in 1 ..< array.count - 1 {
        
        for j in i+1 ..< array.count {
            let current = array[i] + array[j]
            let diff = targetSum - current
            
            if let matchingPairs = hashTable[diff] {
                for pair in matchingPairs {
                    var newEntry = [Int]()
                    newEntry.append(contentsOf: [pair[0], pair[1], array[i], array[j]])
                    output.append(newEntry)
                }
            }
        }
        
        // Adding pairs (before current) to hash table
        var beforeCounter = 0
        while beforeCounter < i {
            let sum = array[beforeCounter] + array[i]
            if hashTable[sum] == nil {
                hashTable[sum] = [[array[beforeCounter], array[i]]]
            } else {
                hashTable[sum]?.append([array[beforeCounter], array[i]])
            }
            beforeCounter += 1
        }
    }
    
    return output
}

// Note:
// The key to this solution is the fact that we only add key-value pairs to the hashtable for pairs to the left of the current index in the array. This is to avoid duplicate solutions. Note also the hash table logic is at the end of the for i in loop, not at the start.



// Question 10 - Subarray Sort

// Solution 1 - Swapping method
// Time - O(n)
// Space - O(n) Note: This can and should be optimized.
func subarraySort(array: [Int]) -> [Int] {
    
    var outOfPlaceIndex = [Int]()
    var largestValue = 0
    var newArray = array
    var minIndex = Int.max
    var maxIndex = Int.max
    
    for i in 0 ..< array.count - 1 {
        
        if array[i] > largestValue {
            largestValue = array[i]
        }
        
        if array[i+1] < largestValue {
            outOfPlaceIndex.append(i+1)
        }
    }
    
    if outOfPlaceIndex.isEmpty {
        return [-1,-1]
    } else {
        maxIndex = outOfPlaceIndex.max()!
    }
    
    for i in outOfPlaceIndex {
        var j = i
        while j-1 >= 0, newArray[j] < newArray[j-1]{
            (newArray[j-1], newArray[j]) = (newArray[j], newArray[j-1])
            if j-1 < minIndex {
                minIndex = j-1
            }
            j -= 1
        }
    }
    
    return [minIndex, maxIndex]
}

subarraySort(array: [1, 2, 4, 7, 10, 11, 7, 12, 6, 7, 16, 18, 19])



// Question 11 - Largest Range

// Solution 1 - Hash table
// Time - O(n)
// Space - O(n)
func largestRange(array: [Int]) -> [Int] {
    var hashtable = [Int: Bool]()
    var longestRange = 0
    var output = [Int]()
    
    // create hashtable
    for i in 0 ..< array.count {
        hashtable[array[i]] = false
    }
    
    for i in 0 ..< array.count {
        // if we've already visited this element, don't repeat
        if hashtable[array[i]] == true {
            break
        }
        
        // check the left range
        var leftArray = [Int]()
        var j = 1
        while hashtable[array[i]-j] != nil {
            leftArray.append(array[i]-j)
            hashtable[array[i]-j] = true
            j += 1
        }
        
        // check the right range
        var rightArray = [Int]()
        var k = 1
        while hashtable[array[i]+k] != nil {
            rightArray.append(array[i]+k)
            hashtable[array[i]+k] = true
            k += 1
        }
        
        // update the longest range
        let completeArray : [Int] = leftArray.reversed() + [array[i]] + rightArray
        let totalRange = completeArray.count
        let lowerBound = completeArray.min()!
        let upperBound = completeArray.max()!
        
        if totalRange > longestRange {
            longestRange = totalRange
            output = [lowerBound, upperBound]
        }
    }
    
    return output
}



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
