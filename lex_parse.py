
import hy
import lex

class Item_Int(lex.Lex_object):
	"""docstring for Item_Int"""
	def __init__(self, arg):
		super(Item_Int, self).__init__(arg)
		try:
			self.t = arg
			self.string = lex.tuple2str(self.t)
			self.value = int(self.string)
		except Exception, e:
			raise "Invalid int"
		else:
			pass
		finally:
			pass

lex_config = (
	(lex.num_reg, Item_Int, 'NUMBER'),
	(lex.blank, lex.Lex_object, "BLANK"),
	(lex.match_plus, lex.Lex_object, "ADD"),
	(lex.match_minus, lex.Lex_object, "MINUS"),
)


		
def lex_one(x):
	for i in lex_config:
		rg, fun,token = i
		o = rg(x)
		t = lex.lex_get(o)
		if o[0][0]:
			return  token,  fun(t)

def lexing(x):
	while x:
		a = lex_one(x)
		print a
		x = x[a[1].length:]