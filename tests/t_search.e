include search.e
include unittest.e

test_equal("find_all() empty", {}, find_all('Z', "ABACDE", 1))
test_equal("find_all() atom", {1,3}, find_all('A', "ABACDE", 1))
test_equal("find_all() atom from", {3}, find_all('A', "ABACDE", 2))
test_equal("find_all() sequence", {3,4}, find_all("Doe", {"John", "Middle", "Doe", "Doe"}, 1))

test_equal("match_all() empty", {}, match_all("ZZ", "ABDCABDEF", 1))
test_equal("match_all() string", {1,5}, match_all("AB", "ABDCABDEF", 1))
test_equal("match_all() string from", {5}, match_all("AB", "ABDCABDEF", 2))
test_equal("match_all() sequence", {1,5}, match_all({1,2}, {1,2,3,4,1,2,4,3}, 1))

test_equal("find_any() from string", 7, find_any("aeiou", "John Doe", 3))
test_equal("find_any() from integers", 6, find_any({1,3,5,8}, {2,4,5,6,7,8,9}, 4))
test_equal("find_any() from floats", 6,
        find_any({1.3,3.5,5.6,8.3}, {2.1,4.2,5.3,6.4,7.5,8.3,9.1}, 4))

test_equal("find_any() empty", 0, find_any("xyz", "John Doe"))
test_equal("find_any() string #1", 2, find_any("aeiou", "John Doe"))
test_equal("find_any() string #2", 3, find_any("Dh", "John Doe"))
test_equal("find_any() integers", 3, find_any({1,3,5,7,9}, {2,4,5,6,7,8,9}))
test_equal("find_any() floats", 3, find_any({1.1,3.2,5.3,7.4,9.5}, {2.1,4.2,5.3,6.4,7.5,8.6,9.7}))

test_equal("rfind() #1", 5, rfind('E', "EEEDEFG"))
test_equal("rfind() #2", 0, rfind('E', "ABC"))

test_equal("rfind() #3", 3, rfind('E', "EEEDEFG", 4))
test_equal("rfind() #4", 0, rfind('E', "ABC", 2))

test_equal("rmatch() #1", 5, rmatch("ABC", "ABCDABC"))
test_equal("rmatch() #2", 0, rmatch("ABC", "DEFBCA"))

test_equal("rmatch() #3", 8, rmatch("ABC", "ABCDABCABC", 9))
test_equal("rmatch() #4", 0, rmatch("ABC", "EEEDDDABC", 5))

test_equal("find_replace() string", "John Smith", find_replace("Doe", "Smith", "John Doe", 0))
test_equal("find_replace() sequence", {1,1,1,1,1}, find_replace({5,2}, {1,1}, {1,5,2,5,2}, 0))
test_equal("find_replace() max set", "BBBAAA", find_replace("A", "B", "AAAAAA", 3))

constant haystack = "012345678ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
test_equal("binary_search missing #1", -10, binary_search('9',haystack))
test_equal("binary_search missing #2", -1, binary_search(0,haystack))
test_equal("binary_search missing #3", -62, binary_search("rubbish",haystack))
test_equal("binary_search found first", 1, binary_search('0',haystack))
test_equal("binary_search found last", 61, binary_search('z',haystack))
test_equal("binary_search found middle#1", 30, binary_search('U',haystack))
test_equal("binary_search found middle#2", 31, binary_search('V',haystack))

test_equal("binary_search found subset #1", 10, binary_search('A',haystack, 5, 17))
test_equal("binary_search found subset #2", -17, binary_search('A',haystack, 17))
test_equal("binary_search found subset #3", -8, binary_search('A',haystack, 1, 7))
test_equal("binary_search found subset #4", -17, binary_search('A',haystack, 17, 1))

test_equal("binary_search empty input", -1, binary_search('A',{}))

test_equal("binary_search strings", 5, binary_search("cat",{"apple", "bat", "car", "cast", "cat", "category", "dog"}))

test_report()

