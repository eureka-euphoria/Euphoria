include std/regex.e as regex
include std/text.e
include std/sequence.e
include std/unittest.e

object ignore = 0

object re = regex:new("[A-Z][a-z]+")
test_true("new()", regex(re))
test_equal("exec() #1", {{5,8}}, regex:find(re, "and John ran"))
regex:free(re)

re = regex:new("([a-z]+) ([A-Z][a-z]+) ([a-z]+)")
test_equal("find() #2", {{1,12}, {1,3}, {5,8}, {10,12}}, regex:find(re, "and John ran"))
regex:free(re)

re = regex:new("[a-z]+")
test_equal("find() #3", {{1,3}}, regex:find(re, "the dog is happy", 1))
test_equal("find() #4", {{5,7}}, regex:find(re, "the dog is happy", 4))
test_equal("find() #5", {{9,10}}, regex:find(re, "the dog is happy", 8))
regex:free(re)

re = regex:new(#/[A-Z][a-z]+\s/, { regex:CASELESS })
test_equal("find() #6", {{1,4}}, regex:find(re, "and John ran"))
test_equal("find() #7", -1, regex:find(re, "15 dogs ran", regex:ANCHORED))
regex:free(re)

re = regex:new(#/[A-Z][a-z]+\s/, { regex:CASELESS, regex:ANCHORED })
test_equal("find() #8", {{1,4}}, regex:find(re, "and John ran"))
test_equal("find() #9", -1, regex:find(re, "15 dogs ran"))
regex:free(re)

re = regex:new("[A-Z]+")
test_equal("find_all() #1", {{{5,7}}, {{13,14}}},
	regex:find_all(re, "the DOG ran UP" ))
regex:free(re)

re = regex:new("^")
test_equal("find_all ^", {{{1,0}}}, regex:find_all(re, "hello world"))
regex:free(re)

re = regex:new("\\b")
test_equal("find_all \\b", {{{1,0}},{{6,5}},{{7,6}},{{12,11}}}, regex:find_all(re, "hello world"))
regex:free(re)

re = regex:new("[A-Z]+")
test_true("is_match() #1", regex:is_match(re, "JOHN"))
test_false("is_match() #2", regex:is_match(re, "john"))
test_true("has_match() #1", regex:has_match(re, "john DOE had a DOG"))
test_false("has_match() #2", regex:has_match(re, "john doe had a dog"))
regex:free(re)

re = regex:new("([A-Z][a-z]+) ([A-Z][a-z]+)")
test_equal("matches() #1", { "John Doe", "John", "Doe" }, regex:matches(re, "John Doe Jane Doe"))
test_equal("all_matches() #1", { { "John Doe", "John", "Doe" }, { "Jane Doe", "Jane", "Doe" } },
	regex:all_matches(re, "John Doe Jane Doe"))
regex:free(re)

re = regex:new(#/,\s/)
test_equal("split() #1", { "euphoria programming", "source code", "reference manual" },
	regex:split(re, "euphoria programming, source code, reference manual"))

test_equal("split_limit() #1", { "euphoria programming", "source code, reference manual" },
	regex:split_limit(re, "euphoria programming, source code, reference manual", 1))
regex:free(re)

re = regex:new("(x)")
test_true("regex matched groups 1", regex(re))
regex:free(re)

re = regex:new("^")
test_equal("regex bol on empty string", {{1,0}}, regex:find(re, ""))
regex:free(re)

re = regex:new("$")
test_equal("regex eol on empty string", {{1,0}}, regex:find(re, ""))
regex:free(re)

re = regex:new("([A-Z][a-z]+) ([A-Z][a-z]+)")
test_equal("find_replace() #1", "hello Doe, John!", regex:find_replace(re, "hello John Doe!", #/\2, \1/))
test_equal("find_replace() #2", "hello DOE, john!", regex:find_replace(re, "hello John Doe!", #/\U\2\e, \L\1\e/))
test_equal("find_replace() #3", "hello \nDoe, John!", regex:find_replace(re, "hello John Doe!", #/\n\2, \1/))
test_equal("find_replace() #4", "hello John\tDoe!", regex:find_replace(re, "hello John Doe!", #/\1\t\2/))
test_equal("find_replace() #5", "hello Mr. John Doe!", regex:find_replace(re, "hello John Doe!", #/Mr. \1 \2/))

test_equal("find_replace_limit() #1", "JOHN DOE Jane Doe", 
	regex:find_replace_limit(re, "John Doe Jane Doe", #/\U\1 \2\e/, 1))

function myupper(sequence params)
	return upper(params[1])
end function

test_equal("find_replace_callback() #1", "JOHN DOE JANE DOE",
	regex:find_replace_callback(re, "John Doe Jane Doe", routine_id("myupper")))
test_equal("find_replace_callback() #2", "JOHN DOE Jane Doe",
	regex:find_replace_callback(re, "John Doe Jane Doe", routine_id("myupper"), 1))
test_equal("find_replace_callback() #3", "John Doe JANE DOE",
	regex:find_replace_callback(re, "John Doe Jane Doe", routine_id("myupper"), 0, 9))

regex:free(re)

test_report()

