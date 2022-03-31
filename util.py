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
				return ((False, read_str), t)
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

