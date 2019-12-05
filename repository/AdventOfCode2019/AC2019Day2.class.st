Class {
	#name : #AC2019Day2,
	#superclass : #Object,
	#category : #AdventOfCode2019
}

{ #category : #puzzles }
AC2019Day2 >> evalIntCode: program [
	"self new evalIntCode: (self new inputProgramWithNoun: 12 verb: 2)"
	| ops pc opCode result |
	ops := Array new: 2.
	ops at: 1 put: [ :arg1 :arg2 | arg1 + arg2 ].
	ops at: 2 put: [ :arg1 :arg2 | arg1 * arg2 ].
	pc := 1.
	[ opCode := program at: pc. opCode = 99 ] 
		whileFalse:[ 
			result := (ops at: opCode) value: (program at: (program at: pc + 1) + 1) value: (program at: (program at: pc + 2) + 1).
			program at: (program at: pc + 3) + 1 put: result.
			pc := pc + 4 ].
	^ program at: 1
]

{ #category : #helpers }
AC2019Day2 >> findNounAndVerb [
	"self new findNounAndVerb"
	0 to: 99 do:[:noun |
		0 to: 99 do:[:verb |
			(self evalIntCode: (self inputProgramWithNoun: noun verb: verb)) = 19690720
				ifTrue:[ ^ 100 * noun + verb ] ] ].
	Error signal: 'No valid combination found'.
]

{ #category : #helpers }
AC2019Day2 >> inputProgramWithNoun: noun verb: verb [
	| program |
	program := (self inputString splitOn: $,) collect:[:str | str asInteger ].
	program at: 2 put: noun.
	program at: 3 put: verb.
	^ program
]

{ #category : #helpers }
AC2019Day2 >> inputString [
	^'1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,10,19,1,19,5,23,2,23,9,27,1,5,27,31,1,9,31,35,1,35,10,39,2,13,39,43,1,43,9,47,1,47,9,51,1,6,51,55,1,13,55,59,1,59,13,63,1,13,63,67,1,6,67,71,1,71,13,75,2,10,75,79,1,13,79,83,1,83,10,87,2,9,87,91,1,6,91,95,1,9,95,99,2,99,10,103,1,103,5,107,2,6,107,111,1,111,6,115,1,9,115,119,1,9,119,123,2,10,123,127,1,127,5,131,2,6,131,135,1,135,5,139,1,9,139,143,2,143,13,147,1,9,147,151,1,151,2,155,1,9,155,0,99,2,0,14,0'
]
