(import os)
(import [reg [*]])

(def num_reg
	(repeat_fn match_digit :min 1))

(def blank
	(repeat_fn (select match_space match_tab ) :min 1))




(defn lex_get [ x]
	(-> x (get 0) (get 1)))
