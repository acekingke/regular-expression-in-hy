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


;;;;;;;;;;;;;

(def phone_match
	(concat match_plus 
		(repeat_fn match_digit :min 2 :max 2)
		match_minus
		(repeat_fn match_digit :min 3 :max 3)
		match_minus
		(repeat_fn match_digit :min 8)))