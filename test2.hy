(import [reg [*]])


(print ( (concat match_digit match_digit) (str2tuple "12") ))
(print ( (select match_digit match_plus) (str2tuple "1") ))
(print ( (select match_digit match_plus) (str2tuple "+") ))
(print ( (repeat_fn match_digit :min 2 :max 3) (str2tuple "1") ))
(print ( (repeat_fn match_digit :min 2 :max 3) (str2tuple "12") ))
(print ( (repeat_fn match_digit :min 2 :max 3) (str2tuple "123") ))

(print 
((concat match_plus 
		(repeat_fn match_digit :min 2 :max 2)
		match_minus
		(repeat_fn match_digit :min 3 :max 3)
		match_minus
		(repeat_fn match_digit :min 8))
 (str2tuple "+86-027-88888888")))


		
(-> (str2tuple "+86-027-88888888") phone_match print)


		
(-> (str2tuple "+86-027-88888888") phone_match print)



(->
	(second (car 
		((concat (repeat_fn match_digit)) (str2tuple "123")))) 
tuple2str int)



(-> (str2tuple "     ") blank)
(-> (str2tuple "     ") blank print)