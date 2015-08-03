
[TOC]

#  Use the hylang design regular expression


I use hylang to make a regular expression ,Do not mean that the regx in javascript/java/python not good (they are   good enough!), and I do not want
to replace them. This is just for show the lisp function programming's convenience . 

Well , now I achivement an little tool use hy(lisp in python).  first of all, We use the phone number for test

		+86-027-88888888
		+\d{2}-\d{3}-\d{8}


Do not panic for system analysis . we extract the basic operations, Or give a recursive definition:  

Regular expression is:

- a single charater is regular expression
- concat: if R1 ,R2 are regular expression, R1 concat R2 are also regular expression
- select:  if R1 ,R2 are regular expression, R1 | R2 are also regular expression
- repeat :R1  repeat concat R1 ,the result is also regular expression


This is the definiton in course , It is not helpful if you use OOP or Procedural programming to achieve the regular expression,
But if use FP to achieve them, It is very helpful, and the definition can translate to high order function directly.

We use the tuple to donate , first group such as "(False , ())" , the "False" tell us do not match , the "()" tell us the charaters had matched
the second group is a tuple, show that the rest of charater need to match.
Such as:

	((False,()) ("1", "2"))

# Basic Function

Use the Hy to define several function:

	(import [os])
	(import [util [concat select repeat_fn ]])
	(defn str2tuple [s]
		(tuple s))

	;;;;;;;;;;;;;;;;;;;;;;;
	;
	; Match funtion group


	(defn match_fn [t fun]
		(cond [(fun (car t)) 
					(, (, True (, (car t)) )
								 (cdr t))]
			  [True (, (, False (,)) t)]))

	;fn 为lamba函数
	; match digit
	(defn match_digit [t] 
		(match_fn t 
		(fn [x] (in  x "0123456789"))))

	(defn match_alpha [t] 
		(match_fn t 
		(fn [x] (in  x "abcdefghijklmnopqrszuvwxyz"))))


	(defn match_plus  [t]
		(match_fn t (fn [x] (= x "+"))))

	(defn match_minus  [t]
		(match_fn t (fn [x] (= x "-"))))




	(defn match_space [t]
		(match_fn t (fn [x] (= x " "))))
	(defn match_tab [t]
		(match_fn t (fn [x] (= x "\t"))))

	(def blank
		(repeat_fn (select match_space match_tab) ))

	(defn tuple2str [x]
		(.join "" x))


This group is the basic function ,of course ,you can writting in Python.

# Concat, Select, Repeat_fn

these function is more procedural, if you Hy to writting, You may be headache. so I achieve in python named util.py as follow:

	# -*- coding:utf-8 -*-
	import sys


	def concat(*args):
		def fun(t):
			flag = True
			count = 0
			leng = len(args)
			rest = t
			s = ()
			read_str =()		
			for e in args:
				if not rest:
					return ((False, read_str), rest)
				(flag,s), rest = e(rest)
				count = count + (1 if flag else 0)
				read_str += (s if flag else ())
			if count == leng:
				return ((True, read_str), rest)
			else:
				return ((False, read_str), rest)
		return fun

	def select(*args):
		def function(t):
			flag = True
			ret = False
			rest = t
			s =  ()
			read_str =()
			for e in args:
				if not rest:
					return ((False, read_str), rest)
				(flag,s), rest = e(rest)
				if flag:
					ret = True
					read_str += s
					break;
			return ((ret,read_str), rest)
		return function


	def repeat_fn(arg, min=0, max= sys.maxint): # just has one arg
		def function(t):
			rest = t
			count = 0
			flag = True
			s = ()
			read_str =()
			while True :
				if not rest:
					return ((False, read_str), rest)
				(flag,s), rest = arg(rest)
				count = count + (1 if flag else 0)
				read_str += ((s if flag else ()))
				if not flag or not rest:
					break
			if count >= min and count <= max:
				return ((True, read_str), rest)
			else:
				return ((False, read_str), rest)
		return function



*NOTE*  
Do not use the parameter t in the function's parameter list. They needn't know the string, the function is high order function
,  It use function to define function


# match one 

	(print ( (concat match_digit match_digit) (str2tuple "12") ))

Result:

	=> (print ( (concat match_digit match_digit) (str2tuple "12") ))
	((True, (u'1', u'2')), ())

# match the phone number

	(def phone_match
		(concat match_plus 
			(repeat_fn match_digit :min 2 :max 2)
			match_minus
			(repeat_fn match_digit :min 3 :max 3)
			match_minus
			(repeat_fn match_digit :min 8)))


	(-> (str2tuple "+86-027-88888888") phone_match print)

Result :
	
	=> (-> (str2tuple "+86-027-88888888") phone_match print)
	
	((True, (u'+', u'8', u'6', u'-', u'0', u'2', u'7', u'-', u'8', u'8', u'8', u'8',
 	u'8', u'8', u'8', u'8')), ())


Enjoy by your self!